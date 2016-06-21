module Main where

import Lexer
import Parser
import Pretty
import Types
import CorePrelude

main :: IO ()
main = do
    unParsed <- getContents
    let scanned = scanTokens unParsed
    let parsed = parseTokens scanned
    putStr $ pprint parsed
