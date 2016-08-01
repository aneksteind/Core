module Core.G where

import qualified Data.Map as M
import Core.Grammar

type GmState = (GmOutput,   -- ^ current output
                GmCode,     -- ^ current instruction stream
                GmStack,    -- ^ current stack
                GmDump,     -- ^ a stack for WHNF reductions
                GmVStack,   -- ^ current v-stack
                GmHeap,     -- ^ heap of nodes
                GmGlobals,  -- ^ global addresses in heap
                GmStats)    -- ^ statistics

type GmOutput = [Char]

type GmCode = [Instruction]

type GmStack = [Addr]

type GmDump = [GmDumpItem]
type GmDumpItem = (GmCode, GmStack)

type GmVStack = [Int]

type GmHeap = Heap Node

type GmGlobals = M.Map Name Addr

type GmStats = Int

-- | G code instructions
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

-- | represents a node that is put into the heap
data Node = NNum Int -- ^ Numbers
          | NAp Addr Addr -- ^ Applications
          | NGlobal Int GmCode -- ^ Globals
          | NInd Addr -- ^ Indirections
          | NConstr Int [Addr] -- ^ Constructing a data type
          deriving (Show)

instance Eq Node where
  NNum a == NNum b = a == b -- needed to check conditions
  NAp a b == NAp c d = False -- not needed
  NGlobal a b == NGlobal c d = False -- not needed
  NInd a == NInd b = False -- not needed
  NConstr a b == NConstr c d = False -- not needed


type Heap a = (Int, Addr, [(Int, a)]) -- TODO: map

type Addr = Int

-- the final instruction of a given code sequence
data FinalInstruction = Final (Int -> Instruction) | Null

type Boxer b = (b -> GmState -> GmState)
type Unboxer a = (Addr -> GmState -> a)
type MOperator a b = (a -> b)
type DOperator a b = (a -> a -> b)
type StateTran = (GmState -> GmState)

data Dyad = Arith | Comp

isAtomicExpr :: Expr a -> Bool
isAtomicExpr (EVar v) = True
isAtomicExpr (ENum n) = True
isAtomicExpr e = False

builtInDyadic :: M.Map Name (Instruction, Dyad)
builtInDyadic = 
  M.fromList [("+", (Add, Arith)), ("-", (Sub, Arith)), ("*", (Mul, Arith)), ("/", (Div, Arith)),
            ("==", (Eq, Comp)), ("/=", (Ne, Comp)), (">=", (Ge, Comp)),
            (">", (Gt, Comp)), ("<=", (Le, Comp)), ("<", (Lt, Comp))]

--------------------------- GMSTATE FUNCTIONS ---------------------------

getOutput :: GmState -> GmOutput
getOutput (o,i ,stack, dump, vstack, heap, globals, stats) = o

putOutput :: GmOutput -> GmState -> GmState
putOutput newO (output, code, stack, dump, vstack, heap, globals, stats) =
 (newO, code, stack, dump, vstack, heap, globals, stats)

getCode :: GmState -> GmCode
getCode (output, code, stack, dump, vstack, heap, globals, stats) = code

putCode :: GmCode -> GmState -> GmState
putCode newCode (output, oldCode, stack, dump, vstack, heap, globals, stats) =
 (output, newCode, stack, dump, vstack, heap, globals, stats)

getStack :: GmState -> GmStack
getStack (output, i, stack, dump, vstack, heap, globals, stats) = stack

putStack :: GmStack -> GmState -> GmState
putStack newStack (output, i, oldStack, dump, vstack, heap, globals, stats) =
 (output, i, newStack, dump, vstack, heap, globals, stats)

getDump :: GmState -> GmDump
getDump (output, i, stack, dump, vstack, heap, globals, stats) = dump

putDump :: GmDump -> GmState -> GmState
putDump newDump (output, i, stack, dump, vstack, heap, globals, stats) =
 (output, i, stack, newDump, vstack, heap, globals, stats)

getVStack :: GmState -> GmVStack
getVStack (o, i, stack, dump, vstack, heap, globals, stats) = vstack

putVStack :: GmVStack -> GmState -> GmState
putVStack newVstack (o, i, stack, dump, vstack, heap, globals, stats) =
 (o, i, stack, dump, newVstack, heap, globals, stats)

getHeap :: GmState -> GmHeap
getHeap (output, i, stack, dump, vstack, heap, globals, stats) = heap

putHeap :: GmHeap -> GmState -> GmState
putHeap newHeap (output, i, stack, dump, vstack, oldHeap, globals, stats) =
 (output, i, stack, dump, vstack, newHeap, globals, stats)

getGlobals :: GmState -> GmGlobals
getGlobals (output, i, stack, dump, vstack, heap, globals, stats) = globals

putGlobals :: Name -> Addr -> GmState -> GmState
putGlobals name addr (output, code, stack, dump, vstack, heap, globals, stats) = 
  let newGlobals = M.insert name addr globals
  in (output, code, stack, dump, vstack, heap, newGlobals, stats)

getStats :: GmState -> GmStats
getStats (output, i, stack, dump, vstack, heap, globals, stats) = stats

putStats :: GmStats -> GmState -> GmState
putStats newStats (output, i, stack, dump, vstack, heap, globals, oldStats) =
 (output, i, stack, dump, vstack, heap, globals, newStats)

statIncSteps :: GmStats -> GmStats
statIncSteps s = s+1


-- adds a node the heap, a new address is created
hAlloc :: Heap a -> a -> (Heap a, Addr)
hAlloc (size, address, cts) n = ((size+1, address+1, (address,n) : cts),address)

-- replaces a the node at address "a" with a new node "n"
-- TODO: see remove function
hUpdate :: Heap a -> Addr -> a -> Heap a
hUpdate (size, free, cts) a n = (size, free, (a,n) : remove cts a)

-- looks up a node in a heap
hLookup :: Heap Node -> Addr -> Maybe Node
hLookup (size,free,cts) a = lookup a cts

-- returns the addresses from the paired (Name, Address) list
hAddresses :: Heap a -> [Addr]
hAddresses (size, free, cts) = [addr | (addr, node) <- cts]

hSize :: Heap a -> Int
hSize (size, free, cts) = size

hNull :: Addr
hNull = 0

hIsnull :: Addr -> Bool
hIsnull a = a == 0

remove :: [(Int,a)] -> Int -> [(Int,a)]
remove [] a = error "hUpdate: nothing in the heap matches the given address"
remove ((val,n):cts) match | match == val = cts
                      | match /= val = (val,n) : remove cts match