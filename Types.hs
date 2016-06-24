module Types where
import Data.Heap
import Data.Map
-- GRAMMAR

data Expr a = EVar Name
            | ENum Int
            | EConstr Int Int
            | EAp (Expr a) (Expr a)
            | ELet IsRec [(a, Expr a)] (Expr a)
            | ECase (Expr a) [Alter a]
            | ELam [a] (Expr a)
            deriving (Show, Eq)

type CoreExpr = Expr Name

type Name = String

type IsRec = Bool

type Alter a = (Int, [a], Expr a)
type CoreAlt = Alter Name

type Program a = [ScDefn a]
type CoreProgram = Program Name

type ScDefn a = (Name, [a], Expr a)
type CoreScDefn = ScDefn Name

recursive :: IsRec
recursive = True

nonRecursive :: IsRec
nonRecursive = False

bindersOf :: [(a,b)] -> [a]
bindersOf defns = [name | (name,rhs) <- defns]

rhssOf :: [(a,b)] -> [b]
rhssOf defns = [rhs | (name,rhs) <- defns]

isAtomicExpr :: Expr a -> Bool
isAtomicExpr (EVar v) = True
isAtomicExpr (ENum n) = True
isAtomicExpr e = False

-- PRETTY PRINTER

data Iseq = INil
          | IStr String
          | IAppend Iseq Iseq
          | IIndent Iseq
          | INewline
          deriving (Show, Eq)

-- GMACHINE COMPILER

type GmState = (GmCode,     -- current instruction stream
                GmStack,    -- current stack
                GmHeap,     -- heap of nodes
                GmGlobals,  -- global addresses in heap
                GmStats)    -- statistics

type GmCode = [Instruction]

type GmStack = [Addr]

type GmHeap = Heap Node

type GmGlobals = ASSOC Name Addr

type GmStats = Int

data Instruction = Unwind
                 | Pushglobal Name
                 | Pushint Int
                 | Push Int
                 | Mkap
                 | Slide Int

data Node = NNum Int -- Numbers
          | NAp Addr Addr -- Applications
          | NGlobal Int GmCode -- Globals

instance Eq Instruction where
  Unwind == Unwind = True
  Pushglobal a == Pushglobal b = a == b
  Pushint a == Pushint b = a == b
  Push a == Push b = a == b
  Mkap == Mkap = True
  Slide a == Slide b = a == b
  _ == _ = False

type Heap a = (Int, [Int], [(Int, a)])
type ASSOC k a = Map k a
type Addr = Int