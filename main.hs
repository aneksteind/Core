module Main where

import Lexer
import Parser
import Pretty
import Types
import System.Environment
import GMachine
import Compiler

main :: IO ()
main = do
    (file:_) <- getArgs
    contents <- readFile file
    let parsed = parseTokens $ scanTokens contents
    print parsed
    run contents
--  putStr $ pprint parsed

run = putStrLn . showResults 
    . eval . compile 
    . parseTokens . scanTokens

--run = print . parseTokens . scanTokens