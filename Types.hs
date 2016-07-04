module Types where
import Data.Map

--------------------------- GRAMMAR ---------------------------

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

--------------------------- PRINTER ---------------------------

data Iseq = INil
          | IStr String
          | IAppend Iseq Iseq
          | IIndent Iseq
          | INewline
          deriving (Show, Eq)

--------------------------- GMACHINE ---------------------------

type GmState = (GmCode,     -- current instruction stream
                GmStack,    -- current stack
                GmDump,     -- a stack for WHNF reductions
                GmHeap,     -- heap of nodes
                GmGlobals,  -- global addresses in heap
                GmStats)    -- statistics

type GmCode = [Instruction]

type GmStack = [Addr]

type GmDump = [GmDumpItem]
type GmDumpItem = (GmCode, GmStack)

type GmHeap = Heap Node

type GmGlobals = ASSOC Name Addr

type GmStats = Int

data Instruction = Unwind
                 | Pushglobal Name
                 | Pushint Int
                 | Push Int
                 | Mkap
                 | Update Int
                 | Pop Int 
                 | Slide Int
                 | Alloc Int deriving (Show)

instance Eq Instruction where
  Unwind == Unwind = True
  Pushglobal a == Pushglobal b = a == b
  Pushint a == Pushint b = a == b
  Push a == Push b = a == b
  Mkap == Mkap = True
  Update a == Update b = a == b
  _ == _ = False

data Node = NNum Int -- Numbers
          | NAp Addr Addr -- Applications
          | NGlobal Int GmCode -- Globals
          | NInd Addr -- Indirections
          deriving (Show)

instance Eq Node where
  NNum a == NNum b = a == b -- needed to check conditions
  NAp a b == NAp c d = False -- not needed
  NGlobal a b == NGlobal c d = False -- not needed
  NInd a == NInd b = False -- not needed


type Heap a = (Int, Addr, [(Int, a)])

type ASSOC k a = Map k a

type Addr = Int

--------------------------- COMPILER ---------------------------

type GmCompiledSC = (Name, Int, GmCode)

type GmCompiler = CoreExpr -> GmEnvironment -> GmCode

type GmEnvironment = ASSOC Name Int

--------------------------- PRELUDE ---------------------------

preludeDefs :: CoreProgram
preludeDefs = [ ("I", ["x"], EVar "x"),
  ("K", ["x","y"], EVar "x"),
  ("K1",["x","y"], EVar "y"),
  ("S", ["f","g","x"], EAp (EAp (EVar "f") (EVar "x"))
  (EAp (EVar "g") (EVar "x"))),
  ("compose", ["f","g","x"], EAp (EVar "f")
  (EAp (EVar "g") (EVar "x"))),
  ("twice", ["f"], EAp (EAp (EVar "compose") (EVar "f")) (EVar "f")) ]








