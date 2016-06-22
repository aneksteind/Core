module Main where

import Lexer
import Parser
import Pretty
import Types
import CorePrelude

main :: IO ()
main = do
    unParsed <- readFile "prelude.cor"
    let scanned = scanTokens unParsed
    let parsed = parseTokens scanned
    putStr $ pprint parsed
