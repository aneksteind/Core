{
module Lexer where
}

%wrapper "basic"

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
    ";;".*                      ;
    $digit+                     { \s -> TokenInt (read s) }
    @string                     { \s -> TokenString (init (tail s)) }
    @char                       { \s -> TokenChar (head (tail s)) }
    @id                         { \s -> TokenSym s }
    [\+]                        { \s -> TokenAdd }
    [\-]                        { \s -> TokenMin }
    [\*]                        { \s -> TokenMul }
    [\/]                        { \s -> TokenDiv }
    [\=]                        { \s -> TokenAssign }
    [\\]                        { \s -> TokenLamVars }
    "."                         { \s -> TokenLamExpr }
    "<"                         { \s -> TokenLT }
    "<="                        { \s -> TokenLTE }
    "=="                        { \s -> TokenEQ }
    "/="                        { \s -> TokenNEQ }
    ">="                        { \s -> TokenGTE }
    ">"                         { \s -> TokenGT }
    "&"                         { \s -> TokenAnd }
    "|"                         { \s -> TokenOr }
    let                         { \s -> TokenLet }
    letrec                      { \s -> TokenLetRec }
    in                          { \s -> TokenIn }
    case                        { \s -> TokenCase }
    of                          { \s -> TokenOf }
    "->"                        { \s -> TokenArrow }
    Pack                        { \s -> TokenPack }
    "{"                         { \s -> TokenLBrace }
    "}"                         { \s -> TokenRBrace }
    "("                         { \s -> TokenLParen }
    ")"                         { \s -> TokenRParen }
    ";"                         { \s -> TokenSemiColon }
    ","                         { \s -> TokenComma }

{

data Token = TokenInt Int
           | TokenString String
           | TokenChar Char
           | TokenSym String
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
           deriving (Eq, Show)

scanTokens = alexScanTokens
}