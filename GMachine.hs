module GMachine where

import Types
import Parser

runProg :: [Char] -> [Char]
runProg = showResults . compile . parse

-- GET SET FUNCTIONS ON 

getCode :: GmState -> GmCode
getCode (code, stack, heap, globals, stats) = code

putCode :: GmCode -> GmState -> GmState
putCode i' (i, stack, heap, globals, stats) = (i', stack, heap, globals, stats)

getStack :: GmState -> GmStack
getStack (i, stack, heap, globals, stats) = stack

putStack :: GmStack -> GmState -> GmState
putStack stack’ (i, stack, heap, globals, stats) =
 (i, stack’, heap, globals, stats)

getHeap :: GmState -> GmHeap
getHeap (i, stack, heap, globals, stats) = heap

putHeap :: GmHeap -> GmState -> GmState
putHeap heap’ (i, stack, heap, globals, stats) =
 (i, stack, heap’, globals, stats)

getGlobals :: GmState -> GmGlobals
getGlobals (i, stack, heap, globals, stats) = globals

getStats :: GmState -> GmStats
getStats (i, stack, heap, globals, stats) = stats

putStats :: GmStats -> GmState -> GmState
putStats stats’ (i, stack, heap, globals, stats) =
 (i, stack, heap, globals, stats’)

statInitial :: GmStats
statInitial = 0

statIncSteps :: GmStats -> GmStats
statIncSteps s = s+1

statGetSteps :: GmStats -> Int
statGetSteps s = s

-- HEAP FUNCTIONS
hInitial :: Heap a
hInitial = (0, [1..], [])

hAlloc :: Heap a -> a -> (Heap a, Addr)
hAlloc (size, (next:free), cts) n = ((size+1, free, (next,n) : cts),next)

hUpdate :: Heap a -> Addr -> a -> Heap a
hUpdate (size, free, cts) a n = (size, free, (a,n) : remove cts a)

hFree :: Heap a -> Addr -> Heap a
hFree (size, free, cts) a = (size-1, a:free, remove cts a)

hLookup :: Heap Node -> Addr -> Maybe Node
hLookup (size,free,cts) a = lookup cts a

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

remove :: [(Int,a)] -> Int -> [(Int,a)]
remove [] a = 
    error ("Attempt to update or free nonexistent address #" ++ shownum a)
remove ((a’,n):cts) a | a == a’ = cts
                      | a /= a’ = (a’,n) : remove cts a

-- EVALUATOR
eval :: GmState -> [GmState]
eval state = state : restStates where
    restStates | gmFinal state = []
               | otherwise     = eval nextState
    nextState = doAdmin (step state)

doAdmin :: GmState -> GmState
doAdmin s = putStats (statIncSteps (getStats s)) s

gmFinal :: GmState -> Bool
gmFinal s = case (getCode s) of []        -> True
                                otherwise -> False

step :: GmState -> GmState
step state = dispatch i (putCode is state) where
    (i:is) = getCode state

dispatch :: Instruction -> GmState -> GmState
dispatch (Pushglobal f) = pushglobal f
dispatch (Pushint n) = pushint n
dispatch Mkap = mkap
dispatch (Push n) = push n
dispatch (Slide n) = slide n
dispatch Unwind = unwind

pushglobal :: Name -> GmState -> Maybe GmState
pushglobal f state = putStack (a: getStack state) state where
 a = lookup f (getGlobals state)

pushint :: Int -> GmState -> GmState
pushint n state =
 putHeap heap’ (putStack (a: getStack state) state) where
  (heap’, a) = hAlloc (getHeap state) (NNum n)

mkap :: GmState -> GmState
mkap state =
 putHeap heap’ (putStack (a:as’) state) where
  (heap’, a) = hAlloc (getHeap state) (NAp a1 a2)
  (a1:a2:as’) = getStack state