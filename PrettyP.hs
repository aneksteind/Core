module PrettyP where

import Types

pprint :: CoreProgram -> String

pprExpr :: CoreExpr -> String
pprExpr (ENum n) = show n
pprExpr (EVar v) = v
pprExpr (EAp e1 e2) = pprExpr e1 ++ " " ++ pprAExpr e2

pprAExpr :: CoreExpr -> String
pprAExpr e | isAtomic e = pprExpr e
           | otherwise  = "(" ++ pprExpr e ++ ")"

--builds sample expressions of n size
mkMultiAp :: Int -> CoreExpr -> CoreExpr -> CoreExpr
mkMultiAp n e1 e2 = foldl EAp e1 (take n e2s)
                        where e2s = e2 : e2s