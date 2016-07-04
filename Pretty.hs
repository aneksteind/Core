module Pretty where

import Types
import GMachine
import Data.Map (toList)

pprint :: CoreProgram -> String
pprint prog = iDisplay (pprProgram prog)

pprProgram :: CoreProgram -> Iseq
pprProgram scdefns = flip iAppend iNewline (iInterleave (iStr ";" `iAppend` iNewline) $ map pprScDefn scdefns)

pprScDefn :: CoreScDefn -> Iseq
pprScDefn (name, vars, expr) = 
    (iStr name) `iAppend` iStr " " `iAppend` (iInterleave (iStr " ") (map iStr vars))
     `iAppend` maybeSpace `iAppend` (pprExpr expr)
     where maybeSpace = case vars of [] -> iStr "= "
                                     _ -> iStr " = "

pprExpr :: CoreExpr -> Iseq
pprExpr (ENum n) = iNum n
pprExpr (EVar v) = iStr v
pprExpr (EAp (EAp (EVar "+") e1) e2) = iConcat [ pprAExpr e1, iStr " + ", pprAExpr e2 ]
pprExpr (EAp (EAp (EVar "-") e1) e2) = iConcat [ pprAExpr e1, iStr " - ", pprAExpr e2 ]
pprExpr (EAp (EAp (EVar "*") e1) e2) = iConcat [ pprAExpr e1, iStr " * ", pprAExpr e2 ]
pprExpr (EAp (EAp (EVar "/") e1) e2) = iConcat [ pprAExpr e1, iStr " / ", pprAExpr e2 ]
pprExpr (EAp (EAp (EVar "<") e1) e2) = iConcat [ pprAExpr e1, iStr " + ", pprAExpr e2 ]
pprExpr (EAp (EAp (EVar "<=") e1) e2) = iConcat [ pprAExpr e1, iStr " + ", pprAExpr e2 ]
pprExpr (EAp (EAp (EVar "==") e1) e2) = iConcat [ pprAExpr e1, iStr " + ", pprAExpr e2 ]
pprExpr (EAp (EAp (EVar ">=") e1) e2) = iConcat [ pprAExpr e1, iStr " + ", pprAExpr e2 ]
pprExpr (EAp (EAp (EVar ">") e1) e2) = iConcat [ pprAExpr e1, iStr " + ", pprAExpr e2 ]
pprExpr (EAp e1 e2) = (pprExpr e1) `iAppend` (iStr " ") `iAppend` (pprAExpr e2)
pprExpr (ELet isrec defns expr) =
    iConcat [ iStr keyword, iIndent (pprDefns defns), iStr " in " `iAppend` pprExpr expr ]
              where keyword | not isrec = "let"
                            | isrec = "letrec"
pprExpr (ECase e1 patterns) =
    iConcat [ iStr "case ", (pprExpr e1), iStr " of ", iIndent $ pprPatterns patterns ]
pprExpr (ELam vars expr) = 
    iConcat [ iStr "(lambda (", iInterleave (iStr " ") (map iStr vars),
              iStr ") ", pprExpr expr, iStr ")"]
pprExpr (EConstr i1 i2) = iConcat [ iStr "Pack {", iStr $ show i1,
                                    iStr ", ", iStr $ show i2, iStr "}"]


pprPatterns :: [CoreAlt] -> Iseq
pprPatterns patterns = 
  iNewline `iAppend` iInterleave (iStr "; " `iAppend` iNewline) (map pprPattern patterns)

pprPattern :: CoreAlt -> Iseq
pprPattern (int, vars@(v:vs), result) = iConcat $
    [iStr "<", iStr $ show int, iStr "> ",
     iInterleave (iStr " ") (map iStr vars),
     iStr " -> ", pprExpr result]
pprPattern (int, [], result) = iConcat $
    [iStr "<", iStr $ show int, iStr ">",
     iStr " -> ", pprExpr result]

pprDefns :: [(Name, CoreExpr)] -> Iseq
pprDefns defns = iNewline `iAppend` iInterleave sep (map pprDefn defns)
                 where sep = iConcat [ iStr ";", iNewline ]

pprDefn :: (Name, CoreExpr) -> Iseq
pprDefn (name, expr) = iConcat [ iStr name, iStr " = ", pprExpr expr ]

pprAExpr :: CoreExpr -> Iseq
pprAExpr e | isAtomicExpr e = pprExpr e
           | otherwise  = (iStr "(") `iAppend` (pprExpr e) `iAppend` (iStr ")")

iNil :: Iseq
iNil = INil

iStr :: String -> Iseq
iStr str = IStr str

iNum :: Int -> Iseq
iNum n = IStr $ show n

iFWNum :: Int -> Int -> Iseq
iFWNum width n = iStr (space (width - length digits) ++ digits)
    where digits = show n

iLayn :: [Iseq] -> Iseq
iLayn seqs = iConcat (map lay_item (zip [1..] seqs))
    where lay_item (n, seq) = iConcat [ iFWNum 4 n, iStr ") ", iIndent seq, iNewline ]

iAppend :: Iseq -> Iseq -> Iseq
iAppend seq1 seq2 | seq2 == INil = seq1
                  | seq1 == INil = seq1
                  | otherwise = IAppend seq1 seq2

iNewline :: Iseq
iNewline = INewline

iIndent :: Iseq -> Iseq
iIndent s = IIndent s

iDisplay :: Iseq -> String
iDisplay s = flatten 0 [(s,0)]

-- keeps track of the current column as well as
-- a work list that includes the current iseq and
-- the indentation for it
flatten :: Int -> [(Iseq,Int)] -> String
flatten col [] = ""
flatten col (((INil), indent):seqs) = flatten col seqs
flatten col (((IStr s), indent):seqs) = s ++ (flatten col seqs)
flatten col (((IAppend seq1 seq2), indent):seqs) = flatten col ((seq1,indent) : (seq2,indent) : seqs)
flatten col ((INewline, indent):seqs) = '\n' : (space indent) ++ (flatten indent seqs)
flatten col ((IIndent s, indent):seqs) = (flatten col ((s, col+4):seqs))

space :: Int -> String
space n = take n $ repeat ' '

iConcat :: [Iseq] -> Iseq
iConcat iseqs = foldr (\iseq acc -> iseq `iAppend` acc) iNil iseqs

iInterleave :: Iseq -> [Iseq] -> Iseq
iInterleave sep (i:is) = iConcat $ i : prependToAll sep is
iInterleave sep [] = iNil

prependToAll sep (i:is) = sep : (i : prependToAll sep is)
prependToAll sep [] = [] 

--builds sample expressions of n size
mkMultiAp :: Int -> CoreExpr -> CoreExpr -> CoreExpr
mkMultiAp n e1 e2 = foldl EAp e1 (take n e2s)
                        where e2s = e2 : e2s

--------------------------- SHOW COMPILATION ---------------------------

showResults :: [GmState] -> [Char]
showResults states = iDisplay (iConcat [
  iNewline, iStr "-----Supercombinator definitions-----", iNewline, iNewline,
  iInterleave iNewline (map (showSC s) (toList $ getGlobals s)),
  iNewline, iNewline, iStr "-----State transitions-----", iNewline, iNewline,
  iLayn (map showState states), iNewline,
  showStats (last states)]) where (s:ss) = states

showSC :: GmState -> (Name, Addr) -> Iseq
showSC s (name, addr) = 
  let maybeAdd = (hLookup (getHeap s) addr)
  in case maybeAdd of Just (NGlobal arity code) -> showSCresult name code
                      Nothing -> error "global not found in heap"

showSCresult :: Name -> GmCode -> Iseq
showSCresult name code = iConcat [ iStr "Code for ",
        iStr name, iNewline, showInstructions code, iNewline, iNewline]

showInstructions :: GmCode -> Iseq
showInstructions is = iConcat [iStr " Code:{",
  iIndent (iInterleave iNewline (map showInstruction is)),
  iStr "}", iNewline]

showInstruction :: Instruction -> Iseq
showInstruction (Pushglobal f) = (iStr "Pushglobal ") `iAppend` (iStr f)
showInstruction (Push n) = (iStr "Push ") `iAppend` (iNum n)
showInstruction (Pushint n) = (iStr "Pushint ") `iAppend` (iNum n)
showInstruction (Update n) = (iStr "Update ") `iAppend` (iNum n)
showInstruction (Pop n) = (iStr "Pop ") `iAppend` (iNum n)
showInstruction (Slide n) = (iStr "Slide ") `iAppend` (iNum n)
showInstruction (Alloc n) = (iStr "Alloc ") `iAppend` (iNum n)
showInstruction (Cond cond1 cond2) = 
  (iStr "Cond {") `iAppend` showInstructions cond1 `iAppend`  showInstructions cond2
showInstruction inst = iStr $ show inst

showState :: GmState -> Iseq
showState s = iConcat [showStack s, iNewline,
  showInstructions (getCode s), iNewline]

showStack :: GmState -> Iseq
showStack s = iConcat [iStr " Stack:[",
  iIndent (iInterleave iNewline
  (map (showStackItem s) (reverse (getStack s)))),
  iStr "]"]

showStackItem :: GmState -> Addr -> Iseq
showStackItem s a = 
  let maybeAddress = (hLookup (getHeap s) a) in
    case maybeAddress of Just address -> iConcat [iStr (showaddr a), iStr ": ", showNode s a address]
                         Nothing -> error "showStackItem: node not found in heap"

showNode :: GmState -> Addr -> Node -> Iseq
showNode s a (NNum n) = iNum n
showNode s a (NGlobal n g) = iConcat [iStr "Global ", iStr v]
  where v = head [n | (n,b) <- toList $ getGlobals s, a==b]
showNode s a (NAp a1 a2) = iConcat [iStr "Ap ", iStr (showaddr a1),
  iStr " ", iStr (showaddr a2)]
showNode s a (NInd ia) = iConcat [iStr "Ind ", iStr (showaddr ia)]

showStats :: GmState -> Iseq
showStats s = iConcat [ iStr "Steps taken = ", iNum (statGetSteps (getStats s))]