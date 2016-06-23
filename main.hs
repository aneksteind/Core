module Main where

import Lexer
import Parser
import Pretty
import Types
import CorePrelude
import System.Environment

main :: IO ()
main = do
    (file:_) <- getArgs
    unParsed <- readFile file
    let scanned = scanTokens unParsed
    print scanned
    let parsed = parseTokens scanned
    putStr $ pprint parsed
