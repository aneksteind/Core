{
module Lexer where
}

%wrapper "posn"

$digit = 0-9
$alpha = [a-zA-Z]
$special = [\.\;\,\$\|\*\+\?\#\~\-\{\}\(\)\[\]\^\/]
$graphic = $printable # $white
$eol   = [\n]

@string     = \" ($graphic # \")* \"
@escape = ’\\’ ($printable | $digit+)
@char = \' ($graphic # $special) \' | \' @escape \'
@id = [A-Za-z][A-Z0-9a-z_]*
@double = [0-9]+[\.][0-9]+


tokens :-
    
    $white+                     ;
    $eol                        ;
    "--".*                      ;
    $digit+                     { tok (\p s -> T (TokenInt) p s) }
    [\+]                        { tok (\p s -> T (TokenAdd) p s) }
    [\-]                        { tok (\p s -> T (TokenMin) p s) }
    [\*]                        { tok (\p s -> T (TokenMul) p s) }
    [\/]                        { tok (\p s -> T (TokenDiv) p s) }
    [\=]                        { tok (\p s -> T (TokenAssign) p s) }
    [\\]                        { tok (\p s -> T (TokenLamVars) p s) }
    "."                         { tok (\p s -> T (TokenLamExpr) p s) }
    "<"                         { tok (\p s -> T (TokenLT) p s) }
    "<="                        { tok (\p s -> T (TokenLTE) p s) }
    "=="                        { tok (\p s -> T (TokenEQ) p s) }
    "/="                        { tok (\p s -> T (TokenNEQ) p s) }
    ">="                        { tok (\p s -> T (TokenGTE) p s) }
    ">"                         { tok (\p s -> T (TokenGT) p s) }
    "&"                         { tok (\p s -> T (TokenAnd) p s) }
    "|"                         { tok (\p s -> T (TokenOr) p s) }
    let                         { tok (\p s -> T (TokenLet) p s) }
    letrec                      { tok (\p s -> T (TokenLetRec) p s) }
    in                          { tok (\p s -> T (TokenIn) p s) }
    case                        { tok (\p s -> T (TokenCase) p s) }
    of                          { tok (\p s -> T (TokenOf) p s) }
    "->"                        { tok (\p s -> T (TokenArrow) p s) }
    Pack                        { tok (\p s -> T (TokenPack) p s) }
    "{"                         { tok (\p s -> T (TokenLBrace) p s) }
    "}"                         { tok (\p s -> T (TokenRBrace) p s) }
    "("                         { tok (\p s -> T (TokenLParen) p s) }
    ")"                         { tok (\p s -> T (TokenRParen) p s) }
    ";"                         { tok (\p s -> T (TokenSemiColon) p s) }
    ","                         { tok (\p s -> T (TokenComma) p s) }
    @id                         { tok (\p s -> T (TokenSym) p s) }

{

tok f p s = f p s

data Token = T TokenClass AlexPosn String

data TokenClass = TokenInt
           | TokenSym
           | TokenAdd
           | TokenMin
           | TokenMul
           | TokenDiv
           | TokenAssign
           | TokenLamVars
           | TokenLamExpr
           | TokenLT
           | TokenLTE
           | TokenEQ
           | TokenNEQ
           | TokenGTE
           | TokenGT
           | TokenAnd
           | TokenOr
           | TokenLet
           | TokenLetRec
           | TokenIn
           | TokenCase
           | TokenOf
           | TokenArrow
           | TokenPack
           | TokenLBrace
           | TokenRBrace
           | TokenLParen
           | TokenRParen
           | TokenSemiColon
           | TokenComma
           | TokenEOF
           deriving (Eq, Show)

showPos :: AlexPosn -> String
showPos (AlexPn _ l c) = show l ++ ":" ++ show c

scanTokens :: String -> [Token]
scanTokens = alexScanTokens
}