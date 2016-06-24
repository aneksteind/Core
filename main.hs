module Main where

import Lexer
import Parser
import Pretty
import Types
import CorePrelude
import System.Environment
import GMachine

main :: IO ()
main = do
    (file:_) <- getArgs
    unParsed <- readFile file
    let parsed = parseTokens $ scanTokens unParsed
    putStr $ pprint parsed
