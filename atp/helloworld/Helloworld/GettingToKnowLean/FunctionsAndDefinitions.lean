def hellostr := "Helloooo"
def lean : String := "Lean"
#eval String.append hellostr (String.append " " lean)
def add1 (n : Nat) : Nat := n + 1
#eval add1 7

def maximum (n : Nat) (k : Nat) : Nat :=
  if n < k then k else n

def spaceBetween (before : String) (after : String) : String :=
  String.append before (String.append " " after)

-- Not an alias, but an a priori independent object of type Type
def Str : Type := String
def aStr : Str := "This is a string"
def bStr : String := "This is also a string"
#check aStr
#check bStr
