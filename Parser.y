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
    lambda            { TokenLamVars }
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



%right ';' in
%nonassoc gt lt gte lte eq neq '.' Pack int var arrow '}' '{' '(' ')'
%left '+' '-'
%left '*' '/' and or

%%

program : sc                                { [$1] }
        | sc ';' program                    { $1 : $3 }

sc : var vars '=' expr                      { ($1, $2, $4) }

vars :                                      { [] }
     | var vars                             { $1 : $2 }

expr : expr aexpr                           { EAp $1 $2 }
     | expr '+' expr                        { EAp (EAp (EVar "+") $1) $3 }
     | expr '-' expr                        { EAp (EAp (EVar "-") $1) $3 }
     | expr '*' expr                        { EAp (EAp (EVar "*") $1) $3 }
     | expr '/' expr                        { EAp (EAp (EVar "/") $1) $3 }
     | expr and expr                        { EAp (EAp (EVar "and") $1) $3 }
     | expr or expr                         { EAp (EAp (EVar "or") $1) $3 }
     | expr lt expr                         { EAp (EAp (EVar "<") $1) $3 }
     | expr lte expr                        { EAp (EAp (EVar "<=") $1) $3 }
     | expr eq expr                         { EAp (EAp (EVar "==") $1) $3 }
     | expr neq expr                        { EAp (EAp (EVar "/=") $1) $3 }
     | expr gte expr                        { EAp (EAp (EVar ">=") $1) $3 }
     | expr gt expr                         { EAp (EAp (EVar ">") $1) $3 }
     | let defns in expr                    { ELet nonRecursive $2 $4 }
     | letrec defns in expr                 { ELet recursive $2 $4 }
     | case expr of alts                    { ECase $2 $4 }
     | lambda var vars '.' expr               { ELam ($2 : $3) $5 }
     | aexpr                                { $1 }

aexpr : var                                 { EVar $1 }
      | int                                 { ENum $1 }
      | Pack '{' int ',' int '}'            { EConstr $3 $5 }
      | '('expr')'                          { $2 }

defns : defn                                { [$1] }
      | defn ';' defns                      { $1 : $3 }

defn : var '=' expr                         { ($1, $3) }

alts : alt ';'                                 { [$1] }
     | alt ';' alts                         { $1 : $3 }

alt : lt int gt vars arrow expr             { ($2, $4, $6) }

{

parseError :: [Token] -> a
parseError _ = error "Parse error"
    

}