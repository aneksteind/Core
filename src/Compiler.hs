module Compiler where

import Types
import GMachine
import Data.List
import qualified Data.Map as M (Map, keys, fromList, map, mapAccum, member, lookup, toList)



-- sets initial state
-- binds the supercombinators to the environment
compile :: CoreProgram -> GmState
compile program = ([], initialCode, [], [], [], heap, globals, statInitial) where
    (heap,globals) = buildInitialHeap program

-- start with the main function and unwind from there
initialCode :: GmCode
initialCode = [Pushglobal "main", Eval, Print]

statInitial :: GmStats
statInitial = 0

-- bind sc's, allocate corresponding nodes in heap
buildInitialHeap :: CoreProgram -> (GmHeap, GmGlobals)
buildInitialHeap program = (heap, M.fromList globals) where
    (heap, globals) = mapAccumL allocateSc hInitial compiled
    compiled = map compileSc (preludeDefs ++ program ++ primitives)

-- allocate node in heap for supercombinator
allocateSc :: GmHeap -> GmCompiledSC -> (GmHeap, (Name, Addr))
allocateSc heap (name, nargs, instructions) = (newHeap, (name, addr)) where
    (newHeap, addr) = hAlloc heap (NGlobal nargs instructions)

hInitial :: Heap a
hInitial = (0, 1, [])

-- compile super combinator
compileSc :: (Name, [Name], CoreExpr) -> GmCompiledSC
compileSc (name, env, body) = 
    let d = length env in 
    (name, d, compileR d body $ M.fromList $ zip env [0..])

-- compile body (Expr) of super combinator, top level
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

-- strictly compile expression to WHNF
-- leaves a pointer to the expression on top of stack
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
    let maybeBinop = M.lookup op builtInDyadic
        mkCode Arith = [Mkint]
        mkCode Comp = [Mkbool] in
    case maybeBinop of 
        Just (binop, dyad) -> compileB e env ++ mkCode dyad
        Nothing    -> compileC e env ++ [Eval]
compileE b@(EAp (EVar "negate") e1) env = compileB b env ++ [Mkint]
compileE (EAp (EAp (EAp (EVar "if") predicate) e1) e2) env =
    compileB predicate env ++ [Cond (compileE e1 env) (compileE e2 env)]
compileE e env = compileC e env ++ [Eval]

-- compiles expression that needs evaluation to WHNF
-- also must be of type Int or Bool
-- leaves the result on top of the V stack
compileB :: GmCompiler
compileB (ENum i) env = [Pushbasic i]
compileB (ELet recursive defs e) args
    | recursive = compileLetrec compileB (Final Pop) defs e args
    | otherwise = compileLet compileB (Final Pop) defs e args
compileB e@(EAp (EAp (EVar op) e1) e2) env = 
    let maybeBinop = M.lookup op builtInDyadic in
    case maybeBinop of 
        Just (binop,_) -> compileB e2 env ++ compileB e1 env ++ [binop]
        _ -> compileE e env
compileB (EAp (EVar "negate") e1) env = compileB e1 env ++ [Neg]
compileB (EAp (EAp (EAp (EVar "if") predicate) e1) e2) env =
    compileB predicate env ++ [Cond (compileB e1 env) (compileB e2 env)]
compileB e env = compileE e env ++ [Get]

-- lazily compile expression
compileC :: GmCompiler
compileC (EVar v) env | elem v (M.keys env) =
    let n = M.lookup v env in case n of Just num -> [Push num]
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

-- compile cases for case expressions               
compileD :: (Int -> GmCompiler) -> [CoreAlt] -> GmEnvironment -> [(Int, GmCode)] 
compileD comp alts env = 
    [(tag, comp (length names) body (M.fromList (zip names [0..] ++ (M.toList $ argOffset (length names) env))))
        | (tag, names, body) <- alts]

-- compiles the code for an alternative for E context
compileAE :: Int -> GmCompiler
compileAE offset expr env = [Split offset] ++ compileE expr env ++ [Slide offset]

-- compiles the code for an alternative for R context
compileAR :: Int -> Int -> GmCompiler
compileAR d offset expr env = [Split offset] ++ compileR (offset + d) expr env

-- compiles let expression, last instruction depends on context
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

-- compiles recursive let expression, last instruction depends on context
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

-- compile the arguments of a let expression
compileArgs :: [(Name, CoreExpr)] -> GmEnvironment -> GmEnvironment
compileArgs defs env = 
    M.fromList $ zip (map fst defs) [n-1, n-2 .. 0] ++ (M.toList $ argOffset n env) where
        n = length defs        

-- compile the arguments of a data type
compileConstrArgs :: Int -> [CoreExpr] -> GmEnvironment -> GmCode
compileConstrArgs numArgs (e:es) env = 
    let compiled = foldl iterCode base es
        iterCode = (\(code, n) x -> ((compileC x (argOffset n env))++code, n+1))
        base = ((compileC e env),1) 
    in fst compiled
compileConstrArgs numArgs [] env = []

-- offsets env bindings by n
argOffset :: Int -> GmEnvironment -> GmEnvironment
argOffset n env = M.map (\v -> v + n) env