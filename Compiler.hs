module Compiler where

import Types
import GMachine
import Data.List
import qualified Data.Map as Map (keys, fromList, map, lookup)

main =  putStrLn "Success!"

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
    compiled = map compileSc program :: [GmCompiledSC]
    -- map compileSc (preludeDefs ++ program) ++ compiledPrimitives

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
compileR e env = compileC e env ++ [Slide (length env + 1), Unwind]

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

--shifts the number associated with a variable by n in the environment
argOffset :: Int -> GmEnvironment -> GmEnvironment
argOffset n env = Map.map (\v -> v + n) env