#eval (1 + 2: Nat)
#eval (1 - 2: Nat)
#eval (1 - 2: Int)
--test comment
/-test comment-/
/- test
comment-/
/-The presence of the type label : Int changes how
Lean interprets the operation - -/
#check (1 - 2: Int)
#check (1 - 2: Nat)
