module Main where

import Lexer
import Pretty
import Types
import CorePrelude

main :: IO ()
main = do
    --unParsed <- getContents
    --let scanned = scanTokens unParsed
    --print scanned
    putStr $ pprint preludeDefs

