module Types where
import Data.Map

--------------------------- GRAMMAR ---------------------------

data Expr a = EVar Name
            | ENum Int
            | EConstr Int Int [Expr a]
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

type GmState = (GmOutput,   -- current output
                GmCode,     -- current instruction stream
                GmStack,    -- current stack
                GmDump,     -- a stack for WHNF reductions
                GmVStack,   -- current v-stack
                GmHeap,     -- heap of nodes
                GmGlobals,  -- global addresses in heap
                GmStats)    -- statistics

type GmOutput = [Char]

type GmCode = [Instruction]

type GmStack = [Addr]

type GmDump = [GmDumpItem]
type GmDumpItem = (GmCode, GmStack)

type GmVStack = [Int]

type GmHeap = Heap Node

type GmGlobals = Map Name Addr

type GmStats = Int

data Instruction = Unwind
                 | Pushbasic Int
                 | Pushglobal Name
                 | Pushint Int
                 | Push Int
                 | Get
                 | Mkap
                 | Mkint
                 | Mkbool
                 | Update Int
                 | Pop Int 
                 | Slide Int
                 | Alloc Int
                 | Eval
                 | Add | Sub | Mul | Div | Neg
                 | Eq | Ne | Lt | Le | Gt | Ge 
                 | Cond GmCode GmCode
                 | Pack Int Int
                 | Casejump [(Int, GmCode)] -- TODO: map
                 | Split Int
                 | Print deriving (Show)

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
          | NConstr Int [Addr]
          deriving (Show)

instance Eq Node where
  NNum a == NNum b = a == b -- needed to check conditions
  NAp a b == NAp c d = False -- not needed
  NGlobal a b == NGlobal c d = False -- not needed
  NInd a == NInd b = False -- not needed
  NConstr a b == NConstr c d = False -- not needed


type Heap a = (Int, Addr, [(Int, a)]) -- TODO: map

type Addr = Int

data FinalInstruction = Final (Int -> Instruction) | Null

--------------------------- COMPILER ---------------------------

type GmCompiledSC = (Name, Int, GmCode)

type GmCompiler = CoreExpr -> GmEnvironment -> GmCode

type GmEnvironment = Map Name Int

--------------------------- PRELUDE ---------------------------

preludeDefs :: CoreProgram
preludeDefs = [ ("I", ["x"], EVar "x"),
  ("K", ["x","y"], EVar "x"),
  ("K1",["x","y"], EVar "y"),
  ("S", ["f","g","x"], EAp (EAp (EVar "f") (EVar "x"))
  (EAp (EVar "g") (EVar "x"))),
  ("compose", ["f","g","x"], EAp (EVar "f")
  (EAp (EVar "g") (EVar "x"))),
  ("twice", ["f"], EAp (EAp (EVar "compose") (EVar "f")) (EVar "f"))]

primitives :: [(Name, [Name], CoreExpr)]
primitives = 
  [("+", ["x","y"], (EAp (EAp (EVar "+") (EVar "x")) (EVar "y"))),
   ("-", ["x","y"], (EAp (EAp (EVar "-") (EVar "x")) (EVar "y"))),
   ("*", ["x","y"], (EAp (EAp (EVar "*") (EVar "x")) (EVar "y"))),
   ("/", ["x","y"], (EAp (EAp (EVar "/") (EVar "x")) (EVar "y"))),
   ("negate", ["x"], (EAp (EVar "negate") (EVar "x"))),
   ("==", ["x","y"], (EAp (EAp (EVar "==") (EVar "x")) (EVar "y"))),
   ("˜=", ["x","y"], (EAp (EAp (EVar "˜=") (EVar "x")) (EVar "y"))),
   (">=", ["x","y"], (EAp (EAp (EVar ">=") (EVar "x")) (EVar "y"))),
   (">", ["x","y"], (EAp (EAp (EVar ">") (EVar "x")) (EVar "y"))),
   ("<=", ["x","y"], (EAp (EAp (EVar "<=") (EVar "x")) (EVar "y"))),
   ("<", ["x","y"], (EAp (EAp (EVar "<") (EVar "x")) (EVar "y"))),
   ("if", ["c","t","f"],
      (EAp (EAp (EAp (EVar "if") (EVar "c")) (EVar "t")) (EVar "f"))),
   ("True", [], (EConstr 2 0 [])),
   ("False", [], (EConstr 1 0 []))]

builtInDyadic :: Map Name (Instruction, Dyad)
builtInDyadic = 
  fromList [("+", (Add, Arith)), ("-", (Sub, Arith)), ("*", (Mul, Arith)), ("/", (Div, Arith)),
            ("==", (Eq, Comp)), ("/=", (Ne, Comp)), (">=", (Ge, Comp)),
            (">", (Gt, Comp)), ("<=", (Le, Comp)), ("<", (Lt, Comp))]



--------------------------- ARITHMETIC ---------------------------
type Boxer b = (b -> GmState -> GmState)
type Unboxer a = (Addr -> GmState -> a)
type MOperator a b = (a -> b)
type DOperator a b = (a -> a -> b)
type StateTran = (GmState -> GmState)

data Dyad = Arith | Comp







