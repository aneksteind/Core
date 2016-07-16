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
    args <- getArgs
    case args of 
        ("run-steps":file:_) -> run showResults file
        (file:_) -> run showFinalResult file
        _ -> error "incorrect arguments"

run :: ([GmState] -> String) -> String -> IO ()
run output file = do
    contents <- readFile file
    runH output contents

runH output = putStrLn . output . eval . compile 
    . parseTokens . scanTokens