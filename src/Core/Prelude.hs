module Core.Prelude where

import Core.Grammar

-- | simple but important functions in Core
preludeDefs :: CoreProgram
preludeDefs = [ ("I", ["x"], EVar "x"),
  ("K", ["x","y"], EVar "x"),
  ("K1",["x","y"], EVar "y"),
  ("S", ["f","g","x"], EAp (EAp (EVar "f") (EVar "x"))
  (EAp (EVar "g") (EVar "x"))),
  ("compose", ["f","g","x"], EAp (EVar "f")
  (EAp (EVar "g") (EVar "x"))),
  ("twice", ["f"], EAp (EAp (EVar "compose") (EVar "f")) (EVar "f"))]

-- | primitive operations
primitives :: CoreProgram
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