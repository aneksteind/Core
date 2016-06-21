{
module Parser where
import Lexer
import Types
}

%name parseTokens
%tokentype { Token }
%error { parseError }

%token
    int             { TokenInt $$ }
    var             { TokenSym $$ }
    '+'             { TokenAdd }
    '-'             { TokenMin }
    '*'             { TokenMul }
    '/'             { TokenDiv }
    '='             { TokenAssign }
    '\\'            { TokenLamVars }
    '.'             { TokenLamExpr }
    lt              { TokenLT }
    lte             { TokenLTE }
    eq              { TokenEQ }
    neq             { TokenNEQ }
    gte             { TokenGTE }
    gt              { TokenGT }
    and             { TokenAnd }
    or              { TokenOr }
    let             { TokenLet }
    letrec          { TokenLetRec }
    in              { TokenIn }
    case            { TokenCase }
    of              { TokenOf }
    arrow           { TokenArrow }
    Pack            { TokenPack }
    '{'             { TokenLBrace }
    '}'             { TokenRBrace }
    '('             { TokenLParen }
    ')'             { TokenRParen }
    ';'             { TokenSemiColon }
    ','             { TokenComma }



%right
%nonassoc gt lt gte lte eq neq and or '=' '.' Pack int var in '/' arrow '}' '{' '(' ')' '\\' ';' ','
%left '+' '-'
%left '*' '/'

%%

program : sc                                {}
        | sc ';' program                    {}

sc : var var vars '=' expr                  {}

vars :                                      { [] }
     | var vars                             { $1 : $2 }

expr : expr aexpr                           { EAp $1 $2 }
     | expr '+' expr                        {}
     | expr '-' expr                        {}
     | expr '*' expr                        {}
     | expr '/' expr                        {}
     | expr and expr                        {}
     | expr or expr                         {}
     | expr lt expr                         {}
     | expr lte expr                        {}
     | expr eq expr                         {}
     | expr neq expr                        {}
     | expr gte expr                        {}
     | expr gt expr                         {}
     | let defns in expr                    { ELet nonRecursive $2 $4 }
     | letrec defns in expr                 { ELet recursive $2 $4 }
     | case expr of alts                    { ECase $2 $4 }
     | '\\' var vars '.' expr               { ELam ($2 : $3) $5 }
     | aexpr                                { $1 }

aexpr : var                                 { EVar $1 }
      | int                                 { ENum $1 }
      | Pack '{' int ',' int '}'            { EConstr $3 $5 }
      | '('expr')'                          { $2 }

defns : defn                                {}
      | defn ';' defns                      {}

defn : var '=' expr                         {}

alts : alt ';'                              {}
     | alt alts                             {}

alt : lt int gt vars arrow expr             { $2 }

{

parseError :: [Token] -> a
parseError _ = error "Parse error"
    

}