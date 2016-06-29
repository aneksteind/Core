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
    unParsed <- readFile file
    let parsed = parseTokens $ scanTokens unParsed
    print $ eval (compile parsed)
--  putStr $ pprint parsed
