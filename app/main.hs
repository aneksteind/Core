module Main where

import Lexer
import Parser
import Core.Pretty
import Core.Grammar
import Core.GMachine
import Core.Compiler
import Core.Prelude
import System.Environment

main :: IO ()
main = do
    args <- getArgs
    case args of 
        ("run-steps":file:_) -> run showResults file
        (file:_) -> run showFinalResult file
        _ -> error "incorrect arguments"

run :: Printer -> String -> IO ()
run printer file = do
    contents <- readFile file
    runH printer contents

runH printer = putStrLn . printer . eval . compile 
    . parseTokens . scanTokens