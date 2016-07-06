module GMachine where

import Types
import Parser
import qualified Data.Map as M (lookup, insert)

--runProg :: [Char] -> [Char]
--runProg = showResults . compile . parse


--------------------------- GET/SET GMSTATE ---------------------------

getCode :: GmState -> GmCode
getCode (code, stack, dump, heap, globals, stats) = code

putCode :: GmCode -> GmState -> GmState
putCode newCode (oldCode, stack, dump, heap, globals, stats) = (newCode, stack, dump, heap, globals, stats)

getStack :: GmState -> GmStack
getStack (i, stack, dump, heap, globals, stats) = stack

putStack :: GmStack -> GmState -> GmState
putStack newStack (i, oldStack, dump, heap, globals, stats) =
 (i, newStack, dump, heap, globals, stats)

getDump :: GmState -> GmDump
getDump (i, stack, dump, heap, globals, stats) = dump

putDump :: GmDump -> GmState -> GmState
putDump newDump (i, stack, dump, heap, globals, stats) =
 (i, stack, newDump, heap, globals, stats)

getHeap :: GmState -> GmHeap
getHeap (i, stack, dump, heap, globals, stats) = heap

putHeap :: GmHeap -> GmState -> GmState
putHeap newHeap (i, stack, dump, oldHeap, globals, stats) =
 (i, stack, dump, newHeap, globals, stats)

getGlobals :: GmState -> GmGlobals
getGlobals (i, stack, dump, heap, globals, stats) = globals

putGlobals :: Name -> Addr -> GmState -> GmState
putGlobals name addr (code, stack, dump, heap, globals, stats) = 
  let newGlobals = M.insert name addr globals
  in (code, stack, dump, heap, newGlobals, stats)

getStats :: GmState -> GmStats
getStats (i, stack, dump, heap, globals, stats) = stats

putStats :: GmStats -> GmState -> GmState
putStats newStats (i, stack, dump, heap, globals, oldStats) =
 (i, stack, dump, heap, globals, newStats)

statInitial :: GmStats
statInitial = 0

statIncSteps :: GmStats -> GmStats
statIncSteps s = s+1

statGetSteps :: GmStats -> Int
statGetSteps s = s

--------------------------- HEAP FUNCTIONS ---------------------------
hInitial :: Heap a
hInitial = (0, 1, [])

-- pairs the next free address with the supplied node
-- increases the size of the heap by 1
-- adds the pair to the heap
-- returns the new heap and the new address that was added
hAlloc :: Heap a -> a -> (Heap a, Addr)
hAlloc (size, address, cts) n = ((size+1, address+1, (address,n) : cts),address)

-- replaces a the node at address "a" with a new node "n"
-- TODO: see remove function
hUpdate :: Heap a -> Addr -> a -> Heap a
hUpdate (size, free, cts) a n = (size, free, (a,n) : remove cts a)

-- removes a (Name,Address) pair
-- adds the address back to the available list
--hFree :: Heap a -> Addr -> Heap a
--hFree (size, free, cts) a = (size-1, a:free, remove cts a)

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

showaddr :: Addr -> [Char]
showaddr a = "#" ++ show a

-- TODO: account for failure
remove :: [(Int,a)] -> Int -> [(Int,a)]
remove [] a = []
remove ((val,n):cts) match | match == val = cts
                      | match /= val = (val,n) : remove cts match

--------------------------- EVALUATOR ---------------------------

-- executes the g-machine by executing each instruction
-- each execution of an instruction is cons'ed to the list
-- the last state in the list is the final instruction
eval :: GmState -> [GmState]
eval state = state : restStates where
    restStates | gmFinal state = []
               | otherwise     = eval nextState
    nextState = doAdmin (step state)

-- increases the statistics, puts the new value into the state
doAdmin :: GmState -> GmState
doAdmin s = putStats (statIncSteps (getStats s)) s

-- checks to see if the current state is the final one
-- the state is final if all of the code has been executed
gmFinal :: GmState -> Bool
gmFinal s = case (getCode s) of []        -> True
                                otherwise -> False

-- makes a state transistion based on the instruction
-- takes out the current instruction from the instruction list
step :: GmState -> GmState
step state = dispatch i (putCode is state) where
    (i:is) = getCode state

-- executes the current instruction
-- moves the machine to the next state
dispatch :: Instruction -> GmState -> GmState
dispatch (Pushglobal f) = pushglobal f
dispatch (Pushint n) = pushint n
dispatch Mkap = mkap
dispatch (Push n) = push n
dispatch (Pop n) = pop n
dispatch (Update n) = update n
dispatch Unwind = unwind
dispatch (Slide n) = slide n
dispatch (Alloc n) = alloc n
dispatch Eval = evalI
dispatch Add = add
dispatch Sub = sub
dispatch Mul = mul
dispatch Div = divide
dispatch Neg = neg
dispatch Eq = eq
dispatch Ne = ne
dispatch Lt = lt
dispatch Le = le
dispatch Gt = gt
dispatch Ge = ge
dispatch (Cond c1 c2) = cond c1 c2

-- finds a unique global node in the heap
-- puts the address of the global node at the top of the stack
pushglobal :: Name -> GmState -> GmState
pushglobal f state =  let a = M.lookup f (getGlobals state) in
  case a of Just add -> putStack (add: getStack state) state
            Nothing  -> error ("pushglobal: global " ++ f ++ " not found in globals")
 
-- pushes an integer node onto the heap
pushint :: Int -> GmState -> GmState
pushint n state = 
  let maybeAddr = M.lookup (show n) (getGlobals state)
      pushintHelper s = putHeap newHeap (putStack (a: getStack s) s)
      (newHeap, a) = hAlloc (getHeap state) (NNum n) in
  case maybeAddr of Just addr -> (putStack (addr: getStack state) state) where
                    Nothing -> pushintHelper $ putGlobals (show n) a state

-- takes the 2 addresses at the top of the address stack
-- and combines them into one address
-- also constructs an application node and puts it in the heap
mkap :: GmState -> GmState
mkap state =
 putHeap newHeap (putStack (newAddress:addresses) state) where
  (newHeap, newAddress) = hAlloc (getHeap state) (NAp a1 a2)
  (a1:a2:addresses) = getStack state

-- gets the current address stack
-- pushes the A(nth) address on top of the stack
push :: Int -> GmState -> GmState
push n state = 
  let as = getStack state
      a = (as !! n) in putStack (a:as) state

-- takes the address at the top of the stack
-- drops the next n addresses from the stack
-- reattaches the address to the stack
slide :: Int -> GmState -> GmState
slide n state = putStack (a : drop n as) state where
  (a:as) = getStack state

update :: Int -> GmState -> GmState
update n state = 
  let (a:as) = getStack state
  in putHeap (hUpdate (getHeap state) (as !! n) (NInd a)) (putStack as state)

-- TODO: better error handling
getArg :: Node -> Maybe Addr
getArg (NAp a1 a2) = return a2

-- takes the address at the top of the stack
-- drops the next n addresses from the stack
-- reattaches the address to the stack
pop :: Int -> GmState -> GmState
pop n state = putStack (drop n stack) state where
  stack = getStack state

-- always the last section
-- if NNum then the g-machine has terminated
-- if NAp then we continue to unwind from the next node
-- if NGlobal then we put it's code to the state and continue
unwind :: GmState -> GmState
unwind state = 
  let stack@(a:as) = getStack state
      dump = getDump state
      heap = getHeap state
      replaceAddrs name = putStack (rearrange name heap stack)
      n = (hLookup heap a)
      newState (NNum num) = updateFromDump a dump state
      newState (NAp a1 a2) = putCode [Unwind] (putStack (a1:a:as) state)
      newState (NInd ia) = putCode [Unwind] (putStack (ia:as) state)
      newState (NGlobal na c) | length as < na = putCode (fst $ head dump) $ putStack (stack !! (length as):(snd $ head dump)) state
                             | otherwise = replaceAddrs na $ putCode c state in
      case n of Just node -> newState node        
                Nothing -> error "unwind: address not found in heap"

updateFromDump :: Addr -> GmDump -> GmState -> GmState
updateFromDump address dump state = 
  case dump of [] -> state
               ((i,s):d) -> putDump d $ putCode i $ putStack (address:s) state

-- replaces the application node addresses in the stack with
-- the addresses of the value being applied to
rearrange :: Int -> GmHeap -> GmStack -> GmStack
rearrange n heap as = 
  let newAs = mapM ((getArg =<<) . hLookup heap) (tail as) in
  case newAs of Just addrs -> take n addrs ++ drop n as
                Nothing -> error "rearrange: address not found in heap" 
  
evalI :: GmState -> GmState
evalI state = 
  let code = getCode state
      (a:as) = getStack state
      dump = getDump state in
  putCode [Unwind] $ putStack [a] $ putDump ((code, as):dump) state

alloc :: Int -> GmState -> GmState
alloc n state = let (newHeap, addrs) = allocNodes n (getHeap state)
                    stack = getStack state in
  putHeap newHeap $ putStack (addrs ++ stack) state

allocNodes :: Int -> GmHeap -> (GmHeap, [Addr])
allocNodes 0 heap = (heap, [])
allocNodes n heap = (heap2, a:as) where
  (heap1, as) = allocNodes (n-1) heap
  (heap2, a) = hAlloc heap1 (NInd hNull)


boxInteger :: Int -> GmState -> GmState
boxInteger n state = 
  putStack (a: getStack state) $ putHeap newHeap state where
    (newHeap, a) = hAlloc (getHeap state) (NNum n)

boxBoolean :: Bool -> GmState -> GmState
boxBoolean b state =
  putStack (a: getStack state) $ putHeap newHeap state where
    (newHeap, a) = hAlloc (getHeap state) (NNum bool)
    bool | b = 1
         | otherwise = 0

comparison :: (Int -> Int -> Bool) -> StateTran
comparison = primitive2 boxBoolean unboxInteger

unboxInteger :: Addr -> GmState -> Int
unboxInteger a state =
  let maybeNode = (hLookup (getHeap state) a)
      unboxErr =  "unbox: unboxing a non-integer"
      heapErr = "unbox: node at address " ++ (show a) ++ " not found in heap"
  in case maybeNode of Just (NNum i) -> i
                       Just _        -> error heapErr
                       _             -> error unboxErr

primitive1 ::  Boxer b -> Unboxer a -> MOperator a b -> StateTran
primitive1 box unbox op state = 
  box (op $ unbox a state) (putStack as state) where
    (a:as) = getStack state

primitive2 :: Boxer b -> Unboxer a -> DOperator a b -> StateTran
primitive2 box unbox op state = 
  box (op (unbox a0 state) (unbox a1 state)) (putStack as state) where
    (a0:a1:as) = getStack state

arithmetic1 :: MOperator Int Int -> StateTran
arithmetic1 = primitive1 boxInteger unboxInteger

arithmetic2 :: DOperator Int Int -> StateTran
arithmetic2 = primitive2 boxInteger unboxInteger

cond :: GmCode -> GmCode -> GmState -> GmState
cond i1 i2 state =
  let (a:as) = getStack state
      heap = getHeap state
      i = getCode state
      maybeNode = hLookup heap a in
  case maybeNode of Just (NNum 1) -> putCode (i1++i) $ putStack as state
                    Just (NNum 0) -> putCode (i2++i) $ putStack as state
                    Just _        -> error "cond: address on top does not point to NNum"
                    _             -> error "cond: address not found in heap"


add :: GmState -> GmState
add state = arithmetic2 (+) state

sub :: GmState -> GmState
sub state = arithmetic2 (-) state

divide :: GmState -> GmState
divide state = arithmetic2 (div) state

mul :: GmState -> GmState
mul state = arithmetic2 (*) state

neg :: GmState -> GmState
neg state = arithmetic1 (* (-1)) state

eq :: GmState -> GmState
eq state = comparison (==) state

ne :: GmState -> GmState
ne state = comparison (/=) state

le :: GmState -> GmState
le state = comparison (<=) state

lt :: GmState -> GmState
lt state = comparison (<) state

gt :: GmState -> GmState
gt state = comparison (>) state

ge :: GmState -> GmState
ge state = comparison (>=) state

