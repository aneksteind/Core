module Core.Grammar (CoreExpr(..),
                     Expr(..),
                     Name,
                     CoreAlt(..),
                     Alter(..),
                     CoreProgram(..),
                     Program(..),
                     CoreScDefn(..),
                     ScDefn(..)) where

-- | AST of the Core language
data Expr a = EVar Name -- ^ a variable
            | ENum Int -- ^ an Int
            | EConstr Int Int [Expr a] -- ^ a type declaration
            | EAp (Expr a) (Expr a) -- ^ function application
            | ELet Bool [(a, Expr a)] (Expr a) -- ^ let/letrec expression
            | ECase (Expr a) [Alter a] -- ^ case expression
            | ELam [a] (Expr a) -- ^ lambda expression (not yet implemented)
            deriving (Show, Eq)

-- | A Core expression
type CoreExpr = Expr Name

type Name = String



-- | a case alternative for a given datatype
type Alter a = (Int -- ^ the datatype number
               ,[a] -- ^ a list of local variable names
               , Expr a -- ^ the expression that the case evaluates to
               )

-- | a case alternative
type CoreAlt = Alter Name

type Program a = [ScDefn a]

-- | A list of super combinator definitions
type CoreProgram = Program Name

type ScDefn a = (Name -- ^ the name of the function/global
               ,[a] -- ^ the list of local variable names
               , Expr a -- ^ the expression the supercombinator evaluates to
               )

-- | A supercombinator definition
type CoreScDefn = ScDefn Name