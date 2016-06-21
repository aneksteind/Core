module Main where

import Parser
import Lexer

main :: IO
main = do
    unParsed <- getContents
    let parsed = parseTokens $ scanTokens unParsed :: [CoreExpr]
    print parsed
