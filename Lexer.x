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
    @double                     { \s -> TokenFloat (read s) }
    @string                     { \s -> TokenString (init (tail s)) }
    @char                       { \s -> TokenChar (head (tail s)) }
    @id                         { \s -> TokenSym s }
    [\+]                        { TokenAdd }
    [\-]                        { TokenMin }
    [\*]                        { TokenMul }
    [\/]                        { TokenDiv }
    [\=]                        { TokenAssign }
    [\\]                        { TokenLamVars }
    "."                         { TokenLamExpr }
    "<"                         { TokenLT }
    "<="                        { TokenLTE }
    "=="                        { TokenEQ }
    "/="                        { TokenNEQ }
    ">="                        { TokenGTE }
    ">"                         { TokenGT }
    "&"                         { TokenAnd }
    "|"                         { TokenOr }
    let                         { TokenLet }
    letrec                      { TokenLetRec }
    in                          { TokenIn }
    case                        { TokenCase }
    of                          { TokenOf }
    "->"                        { TokenArrow }
    Pack                        { TokenPack }
    "{"                         { TokenLBrace }
    "}"                         { TokenRBrace }
    "("                         { TokenLParen }
    ")"                         { TokenRParen }
    ";"                         { TokenColon }

{

data Token = TokenInt Integer
           | TokenFloat Double
           | TokenString String
           | TokenChar Character
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
           | TokenColon
}