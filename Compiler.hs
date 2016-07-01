module Compiler where

import Types
import GMachine
import Data.List
import qualified Data.Map as Map (keys, fromList, map, lookup, toList)



-- turns a program into an initial state for the gmachine
-- finds the main super combinator and evaluates it
-- heap initialized containing nodes for each global sc
compile :: CoreProgram -> GmState
compile program = (initialCode, [], heap, globals, statInitial) where
    (heap,globals) = buildInitialHeap program

-- allocates nodes for each global sc
-- produces a list with all the names and pairs
buildInitialHeap :: CoreProgram -> (GmHeap, GmGlobals)
buildInitialHeap program = (heap, Map.fromList globals) where
    (heap, globals) = mapAccumL allocateSc hInitial compiled
    compiled = map compileSc (preludeDefs ++ program) ++ compiledPrimitives :: [GmCompiledSC]

compiledPrimitives :: [GmCompiledSC]
compiledPrimitives = []

-- creates a tuple of a heap, and a name/address pair
allocateSc :: GmHeap -> GmCompiledSC -> (GmHeap, (Name, Addr))
allocateSc heap (name, nargs, instructions) = (newHeap, (name, addr)) where
    (newHeap, addr) = hAlloc heap (NGlobal nargs instructions)

-- start with the main function and unwind from there
initialCode :: GmCode
initialCode = [Pushglobal "main", Unwind]

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
    compileC e env ++ [Update n, Pop n, Unwind]

-- var: if var is part of the environment then push n
-- var: otherwise, push global and make it part of the env
-- int: push int
-- app: compile each expression, append it to the instructions
-- app: offset the env by 1 so that when compileC (EVar) evaluates..
-- (cont) it will push for the correct variable
compileC :: GmCompiler
compileC (EVar v) env | elem v (Map.keys env) =
    let n = Map.lookup v env in case n of Just num -> [Push num]
                                          Nothing -> error "variable not in environment"
                      | otherwise = [Pushglobal v]
compileC (ENum nm) env = [Pushint nm]
compileC (EAp e1 e2) env = 
    compileC e2 env ++ compileC e1 (argOffset 1 env) ++ [Mkap]
compileC (ELet recursive defs e) args
    | recursive = compileLetrec compileC defs e args
    | otherwise = compileLet compileC defs e args

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