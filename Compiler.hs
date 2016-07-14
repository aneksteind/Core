module Compiler where

import Types
import GMachine
import Data.List
import qualified Data.Map as Map (keys, fromList, map, member, lookup, toList)



-- turns a program into an initial state for the gmachine
-- finds the main super combinator and evaluates it
-- heap initialized containing nodes for each global sc
compile :: CoreProgram -> GmState
compile program = ([], initialCode, [], [], [], heap, globals, statInitial) where
    (heap,globals) = buildInitialHeap program

-- allocates nodes for each global sc
-- produces a list with all the names and pairs
buildInitialHeap :: CoreProgram -> (GmHeap, GmGlobals)
buildInitialHeap program = (heap, Map.fromList globals) where
    (heap, globals) = mapAccumL allocateSc hInitial compiled
    compiled = map compileSc (preludeDefs ++ program ++ primitives)

-- creates a tuple of a heap, and a name/address pair
allocateSc :: GmHeap -> GmCompiledSC -> (GmHeap, (Name, Addr))
allocateSc heap (name, nargs, instructions) = (newHeap, (name, addr)) where
    (newHeap, addr) = hAlloc heap (NGlobal nargs instructions)

-- start with the main function and unwind from there
initialCode :: GmCode
initialCode = [Pushglobal "main", Eval, Print]

-- each super combinator compiled with this function
-- zips variable names with numbers 0..
-- returns a triple containing name, arguments, and instructions
-- compileSc is also  ::   CoreScDefn -> GmCompiledSC
compileSc :: (Name, [Name], CoreExpr) -> GmCompiledSC
compileSc (name, env, body) = 
    let d = length env in 
    (name, d, compileR d body $ Map.fromList $ zip env [0..])

-- produces the instructions for the current CoreExpr
-- appends those instructions to the finish, which is to
-- slide the stack and to unwind
compileR :: Int -> GmCompiler
compileR d (ELet recursive defs e) env 
    | recursive = compileLetrec (compileR (d + length defs)) Null defs e env
    | otherwise = compileLet (compileR (d + length defs)) Null defs e env
compileR d (EAp (EAp (EAp (EVar "if") predicate) e1) e2) env =
    compileB predicate env ++ [Cond (compileR d e1 env) (compileR d e2 env)]
compileR d (ECase e alts) env = compileE e env ++
    [Casejump $ compileD (compileAR d) alts env]
compileR d e env =
    compileE e env ++ [Update d, Pop d, Unwind]

-- var: if var is part of the environment then push n
-- var: otherwise, push global and make it part of the env
-- int: push int
-- app: compile each expression, append it to the instructions
-- app: offset the env by 1 so that when compileC (EVar) evaluates..
-- (cont) it will push for the correct variable
compileC :: GmCompiler
compileC (EVar v) env | elem v (Map.keys env) =
    let n = Map.lookup v env in case n of Just num -> [Push num]
                                          Nothing -> error "compileC: variable not in environment"
                      | otherwise = [Pushglobal v]
compileC (ENum nm) env = [Pushint nm]
compileC (EAp e1 e2) env = 
    compileC e2 env ++ compileC e1 (argOffset 1 env) ++ [Mkap]
compileC (EConstr t n es) env | length es == n = compileConstrArgs n es env ++ [Pack t n]
                              | otherwise = error $ "too many or too little arguments in constructor " ++ show t
compileC (ECase e alts) env = compileE e env ++
    [Casejump $ compileD compileAE alts env]
compileC (ELet recursive defs e) args
    | recursive = compileLetrec compileC (Final Slide) defs e args
    | otherwise = compileLet compileC (Final Slide) defs e args

compileE :: GmCompiler
compileE (ENum i) env = [Pushint i]
compileE (ELet recursive defs e) args
    | recursive = compileLetrec compileE (Final Slide) defs e args
    | otherwise = compileLet compileE (Final Slide) defs e args
compileE (ECase e alts) env = compileE e env ++
    [Casejump $ compileD compileAE alts env]
compileE (EConstr t n es) env | length es == n =
    compileConstrArgs n es env ++ [Pack t n]
                              | otherwise =
    error $ "too many or too little arguments in constructor " ++ show t
compileE e@(EAp (EAp (EVar op) e1) e2) env = 
    let maybeBinop = Map.lookup op builtInDyadic
        mkCode Arith = [Mkint]
        mkCode Comp = [Mkbool] in
    case maybeBinop of 
        Just (binop, dyad) -> compileB e env ++ mkCode dyad
        Nothing    -> compileC e env ++ [Eval]
compileE b@(EAp (EVar "negate") e1) env = compileB b env ++ [Mkint]
compileE (EAp (EAp (EAp (EVar "if") predicate) e1) e2) env =
    compileB predicate env ++ [Cond (compileE e1 env) (compileE e2 env)]
compileE e env = compileC e env ++ [Eval]

compileB :: GmCompiler
compileB (ENum i) env = [Pushbasic i]
compileB (ELet recursive defs e) args
    | recursive = compileLetrec compileB (Final Pop) defs e args
    | otherwise = compileLet compileB (Final Pop) defs e args
compileB e@(EAp (EAp (EVar op) e1) e2) env = 
    let maybeBinop = Map.lookup op builtInDyadic in
    case maybeBinop of 
        Just (binop,_) -> compileB e2 env ++ compileB e1 env ++ [binop]
        _ -> compileE e env
compileB (EAp (EVar "negate") e1) env = compileB e1 env ++ [Neg]
compileB (EAp (EAp (EAp (EVar "if") predicate) e1) e2) env =
    compileB predicate env ++ [Cond (compileB e1 env) (compileB e2 env)]
compileB e env = compileE e env ++ [Get]

compileConstrArgs :: Int -> [CoreExpr] -> GmEnvironment -> GmCode
compileConstrArgs numArgs (e:es) env = 
    let compiled = foldl iterCode base es
        iterCode = (\(code, n) x -> ((compileC x (argOffset n env))++code, n+1))
        base = ((compileC e env),1) 
    in fst compiled
compileConstrArgs numArgs [] env = []

-- (Int -> GmCompiler): compiler for alternative bodies
-- [CoreAlt]: the list of alternatives
-- GmEnvironment: the current environment
-- [(Int, GmCode)]: list of alternative code sequences                 
compileD :: (Int -> GmCompiler) -> [CoreAlt] -> GmEnvironment -> [(Int, GmCode)] 
compileD comp alts env = 
    [(tag, comp (length names) body (Map.fromList (zip names [0..] ++ (Map.toList $ argOffset (length names) env))))
        | (tag, names, body) <- alts]

compileAE :: Int -> GmCompiler
compileAE offset expr env = [Split offset] ++ compileE expr env ++ [Slide offset]

compileAR :: Int -> Int -> GmCompiler
compileAR d offset expr env = [Split offset] ++ compileR (offset + d) expr env

compileLet :: GmCompiler -> FinalInstruction -> [(Name, CoreExpr)] -> GmCompiler
compileLet comp (Final inst) defs expr env = 
    compileLetH2 comp defs expr env ++ [inst (length defs)]
compileLet comp Null defs expr env =
    compileLetH2 comp defs expr env

compileLetH :: [(Name, CoreExpr)] -> GmEnvironment -> GmCode
compileLetH [] env = []
compileLetH ((name, expr):defs) env = 
    compileC expr env ++ compileLetH defs (argOffset 1 env)

compileLetH2 :: GmCompiler -> [(Name, CoreExpr)] -> GmCompiler
compileLetH2 comp defs expr env = compileLetH defs env ++ comp expr newEnv where
    newEnv = compileArgs defs env

compileLetrec :: GmCompiler -> FinalInstruction -> [(Name, CoreExpr)] -> GmCompiler
compileLetrec comp (Final inst) defs expr env =
    compileLetrecH2 comp defs expr env ++ [inst (length defs)]
compileLetrec comp Null defs expr env =
    compileLetrecH2 comp defs expr env

compileLetrecH :: [(Name, CoreExpr)] -> GmEnvironment -> Int -> GmCode
compileLetrecH [] env n = []
compileLetrecH ((name, expr):defs) env n = 
    compileC expr env ++ [Update n] ++ (compileLetrecH defs env (n-1))

compileLetrecH2 :: GmCompiler -> [(Name, CoreExpr)] -> GmCompiler
compileLetrecH2 comp defs expr env = 
    [Alloc n] ++ compileLetrecH defs newEnv (n-1) ++
    comp expr newEnv where
        newEnv = compileArgs defs env
        n = (length defs)

compileArgs :: [(Name, CoreExpr)] -> GmEnvironment -> GmEnvironment
compileArgs defs env = 
    Map.fromList $ zip (map fst defs) [n-1, n-2 .. 0] ++ (Map.toList $ argOffset n env) where
        n = length defs

--shifts the number associated with a variable by n in the environment
argOffset :: Int -> GmEnvironment -> GmEnvironment
argOffset n env = Map.map (\v -> v + n) env