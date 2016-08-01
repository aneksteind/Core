{
module Parser where
import Lexer
import Core.Grammar
}

%name parseTokens
%tokentype { Token }
%error { parseError }

%token
    int             { T TokenInt p $$ }
    var             { T TokenSym p $$ }
    '+'             { T TokenAdd p _ }
    '-'             { T TokenMin p _ }
    '*'             { T TokenMul p _ }
    '/'             { T TokenDiv p _ }
    '='             { T TokenAssign p _ }
    lambda          { T TokenLamVars p _ }
    '.'             { T TokenLamExpr p _ }
    lt              { T TokenLT p _ }
    lte             { T TokenLTE p _ }
    eq              { T TokenEQ p _ }
    neq             { T TokenNEQ p _ }
    gte             { T TokenGTE p _ }
    gt              { T TokenGT p _ }
    and             { T TokenAnd p _ }
    or              { T TokenOr p _ }
    let             { T TokenLet p _ }
    letrec          { T TokenLetRec p _ }
    in              { T TokenIn p _ }
    case            { T TokenCase p _ }
    of              { T TokenOf p _ }
    arrow           { T TokenArrow p _ }
    Pack            { T TokenPack p _ }
    '{'             { T TokenLBrace p _ }
    '}'             { T TokenRBrace p _ }
    '('             { T TokenLParen p _ }
    ')'             { T TokenRParen p _ }
    ';'             { T TokenSemiColon p _ }
    ','             { T TokenComma p _ }



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
     | lambda var vars '.' expr             { ELam ($2 : $3) $5 }
     | aexpr                                { $1 }

aexpr : var                                 { EVar $1 }
      | int                                 { ENum (read $1 :: Int) }
      | Pack '{' int ',' int '}' '('exprs')'    { EConstr (read $3 :: Int) (read $5 :: Int) $8}
      | '('expr')'                          { $2 }

exprs :                                     { [] }
      | exprsH                              { $1 }

exprsH : expr                               { [$1] }
       | expr ',' exprsH                    { $1 : $3 }

defns : defn                                { [$1] }
      | defn ';' defns                      { $1 : $3 }

defn : var '=' expr                         { ($1, $3) }

alts : alt ';'                                 { [$1] }
     | alt ';' alts                         { $1 : $3 }

alt : lt int gt vars arrow expr             { ((read $2 :: Int), $4, $6) }

{

type IsRec = Bool

recursive :: IsRec
recursive = True

nonRecursive :: IsRec
nonRecursive = False

parseError :: [Token] -> a
parseError ts =
  case ts of
    [] -> error "unexpected end of file"
    token@(T t p s):_ ->
      error $ "parse error " ++ showPos p ++ " - unexpected '" ++ show token ++ "'"

}