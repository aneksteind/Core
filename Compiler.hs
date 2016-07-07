module Compiler where

import Types
import GMachine
import Data.List
import qualified Data.Map as Map (keys, fromList, map, lookup, toList)



-- turns a program into an initial state for the gmachine
-- finds the main super combinator and evaluates it
-- heap initialized containing nodes for each global sc
compile :: CoreProgram -> GmState
compile program = ("", initialCode, [], [], heap, globals, statInitial) where
    (heap,globals) = buildInitialHeap program

-- allocates nodes for each global sc
-- produces a list with all the names and pairs
buildInitialHeap :: CoreProgram -> (GmHeap, GmGlobals)
buildInitialHeap program = (heap, Map.fromList globals) where
    (heap, globals) = mapAccumL allocateSc hInitial compiled
    compiled = map compileSc (preludeDefs ++ program) ++ compiledPrimitives :: [GmCompiledSC]

compiledPrimitives :: [GmCompiledSC]
compiledPrimitives = 
    [("+", 2, [Push 1, Eval, Push 1, Eval, Add, Update 2, Pop 2, Unwind]),
    ("-", 2, [Push 1, Eval, Push 1, Eval, Sub, Update 2, Pop 2, Unwind]),
    ("*", 2, [Push 1, Eval, Push 1, Eval, Mul, Update 2, Pop 2, Unwind]),
    ("/", 2, [Push 1, Eval, Push 1, Eval, Div, Update 2, Pop 2, Unwind]),
    ("negate", 1, [Push 0, Eval, Neg, Update 1, Pop 1, Unwind]),
    ("==", 2, [Push 1, Eval, Push 1, Eval, Eq, Update 2, Pop 2, Unwind]),
    ("/=", 2, [Push 1, Eval, Push 1, Eval, Ne, Update 2, Pop 2, Unwind]),
    ("<", 2, [Push 1, Eval, Push 1, Eval, Lt, Update 2, Pop 2, Unwind]),
    ("<=", 2, [Push 1, Eval, Push 1, Eval, Le, Update 2, Pop 2, Unwind]),
    (">", 2, [Push 1, Eval, Push 1, Eval, Gt, Update 2, Pop 2, Unwind]),
    (">=", 2, [Push 1, Eval, Push 1, Eval, Ge, Update 2, Pop 2, Unwind]),
    ("if", 3, [Push 0, Eval, Cond [Push 1] [Push 2], Update 3, Pop 3, Unwind])]

-- creates a tuple of a heap, and a name/address pair
allocateSc :: GmHeap -> GmCompiledSC -> (GmHeap, (Name, Addr))
allocateSc heap (name, nargs, instructions) = (newHeap, (name, addr)) where
    (newHeap, addr) = hAlloc heap (NGlobal nargs instructions)

-- start with the main function and unwind from there
initialCode :: GmCode
initialCode = [Pushglobal "main", Unwind, Print]

-- each super combinator compiled with this function
-- zips variable names with numbers 0..
-- returns a triple containing name, arguments, and instructions
-- compileSc is also  ::   CoreScDefn -> GmCompiledSC
compileSc :: (Name, [Name], CoreExpr) -> GmCompiledSC
compileSc (name, env, body) = (name, length env, compileR body $ Map.fromList $ zip env [0..])

-- produces the instructions for the current CoreExpr
-- appends those instructions to the finish, which is to
-- slide the stack and to unwind
compileR :: GmCompiler
compileR e env = let n = length env in 
    compileE e env ++ [Update n, Pop n, Unwind]

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
compileC (EConstr t n es) env = compileECH n es env ++ [Pack t n]
compileC (ECase e alts) env = compileE e env ++
    [Casejump $ compileAlts compileESS alts env]
compileC (ELet recursive defs e) args
    | recursive = compileLetrec compileC defs e args
    | otherwise = compileLet compileC defs e args

compileE :: GmCompiler
compileE (ENum nm) env = [Pushint nm]
compileE (ELet recursive defs e) args
    | recursive = compileLetrec compileE defs e args
    | otherwise = compileLet compileE defs e args
compileE (ECase e alts) env = compileE e env ++
    [Casejump $ compileAlts compileESS alts env]
compileE (EAp (EAp (EVar "+") e1) e2) env = compileEB "+" e1 e2 env
compileE (EAp (EAp (EVar "-") e1) e2) env = compileEB "-" e1 e2 env
compileE (EAp (EAp (EVar "*") e1) e2) env = compileEB "*" e1 e2 env
compileE (EAp (EAp (EVar "/") e1) e2) env = compileEB "/" e1 e2 env
compileE (EAp (EAp (EVar "<") e1) e2) env = compileEB "<" e1 e2 env
compileE (EAp (EAp (EVar "<=") e1) e2) env = compileEB "<=" e1 e2 env
compileE (EAp (EAp (EVar "==") e1) e2) env = compileEB "==" e1 e2 env
compileE (EAp (EAp (EVar "/=") e1) e2) env = compileEB "/=" e1 e2 env
compileE (EAp (EAp (EVar ">=") e1) e2) env = compileEB ">=" e1 e2 env
compileE (EAp (EAp (EVar ">") e1) e2) env = compileEB ">" e1 e2 env
compileE (EAp (EVar "negate") e1) env = compileE e1 env ++ [Neg]
compileE (EAp (EAp (EAp (EVar "if") predicate) e1) e2) env = 
    compileE predicate env ++ [Cond (compileE e1 env) (compileE e2 env)]
compileE (EConstr t n es) env = compileECH n es env ++ [Pack t n]
compileE e env = compileC e env ++ [Eval]

compileECH :: Int -> [CoreExpr] -> GmEnvironment -> GmCode
compileECH numArgs (e:es) env = 
    let compiled = foldl iterCode base es
        iterCode = (\(code, n) x -> ((compileC x (argOffset n env))++code, n+1))
        base = ((compileC e env),1) 
    in fst compiled
compileECH numArgs [] env = []

compileEB :: String -> CoreExpr -> CoreExpr -> GmEnvironment -> GmCode
compileEB op e0 e1 env =
    let maybeBinop = Map.lookup op builtInDyadic
        compileBinop bo = compileE e1 env ++ compileE e0 (argOffset 1 env) ++ [bo]
        errorMsg = "compileEB: operation " ++ op ++ " not defined" in
    case maybeBinop of Just binop -> compileBinop binop
                       Nothing -> error errorMsg
       
-- (Int -> GmCompiler): compiler for alternative bodies
-- [CoreAlt]: the list of alternatives
-- GmEnvironment: the current environment
-- [(Int, GmCode)]: list of alternative code sequences                 
compileAlts :: (Int -> GmCompiler) -> [CoreAlt] -> GmEnvironment -> [(Int, GmCode)] 
compileAlts comp alts env = 
    [(tag, comp (length names) body (Map.fromList (zip names [0..] ++ (Map.toList $ argOffset (length names) env))))
        | (tag, names, body) <- alts]

compileESS :: Int -> GmCompiler
compileESS offset expr env = [Split offset] ++ compileE expr env ++ [Slide offset]

compileLetrec :: GmCompiler -> [(Name, CoreExpr)] -> GmCompiler
compileLetrec comp defs expr env =
    [Alloc n] ++ compileLetrecH defs newEnv (n-1) ++
    comp expr newEnv ++ [Slide n] where
        newEnv = compileArgs defs env
        n = (length defs)

compileLetrecH :: [(Name, CoreExpr)] -> GmEnvironment -> Int -> GmCode
compileLetrecH [] env n = []
compileLetrecH ((name, expr):defs) env n = 
    compileC expr env ++ [Update n] ++ (compileLetrecH defs env (n-1))

compileLet :: GmCompiler -> [(Name, CoreExpr)] -> GmCompiler
compileLet comp defs expr env = 
    compileLetH defs env ++ comp expr newEnv ++ [Slide (length defs)] where
        newEnv = compileArgs defs env

compileLetH :: [(Name, CoreExpr)] -> GmEnvironment -> GmCode
compileLetH [] env = []
compileLetH ((name, expr):defs) env = 
    compileC expr env ++ compileLetH defs (argOffset 1 env)

compileArgs :: [(Name, CoreExpr)] -> GmEnvironment -> GmEnvironment
compileArgs defs env = 
    Map.fromList $ zip (map fst defs) [n-1, n-2 .. 0] ++ (Map.toList $ argOffset n env) where
        n = length defs

--shifts the number associated with a variable by n in the environment
argOffset :: Int -> GmEnvironment -> GmEnvironment
argOffset n env = Map.map (\v -> v + n) env