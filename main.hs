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
    let compiled = compile . parseTokens . scanTokens
    --print $ compiled contents
    run contents

run = putStrLn . showFinalResult 
    . eval . compile 
    . parseTokens . scanTokens