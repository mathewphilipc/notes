#check 1.2
#check -454.2123215
#check 0.0
#check 0
#check (0 : Float)

--structure def for Cartesian point
structure Point where
  x : Float
  y : Float
--instantiate instance of above structure
def origin : Point := { x := 0.0, y := 0.0 }
#check origin
#eval origin
#eval origin.x
#eval origin.y
--Define function mapping two points to their sum
def addPoints (p1 : Point) (p2 : Point) : Point :=
  { x := p1.x + p2.x, y := p1.y + p2.y }
def distance (p1 : Point) (p2 : Point) : Float :=
  Float.sqrt (((p2.x - p1.x)^2.0) + ((p2.y - p1.y)^2.0))
--Interesting! Function signature of addPoints lets us infer the types of args
--Concretely, Lean infers that {1.0, 2.0} should be the Point with that data
#eval addPoints { x := 1.0, y := 2.0} { x := 5.0, y := -1.0}
--If we want to be explicit about the arg types
#eval addPoints
  ({x := 1.0, y := 2.0} : Point)
  ({x := 5.0, y := -1.0} : Point)
/-One caveat: Lean does not normally do runtime dispatch based on argument
types; type-dependent behavior is usually expressed through
overloading/typeclasses or separate definitions.
-/
#eval distance { x := 1.0, y := 2.0} { x := 5.0, y := -1.0 }
structure Point3D where
  x : Float
  y : Float
  z : Float
def origin3D : Point3D := {x := 0.0, y := 0.0, z := 0.0}
---invalid {...} notation, expected type is not known
--#check { x := 0.0, y := 0.0}
#check ({ x := 0.0, y := 0.0} : Point)
--Ugly: Lean also allows the structure type annotation inside the curly braces.
#check { x := 0.0, y := 0.0 : Point}
/-In functional programming communities, what is almost always meant by this
kind of statement is that a fresh Point is allocated with the x field pointing
to the new value, and all other fields pointing to the original values from the
input.
-/
def zeroX (p : Point) : Point := { x := 0, y := p.y }
def betterZeroX (p : Point) : Point := { p with x := 0}
def examplePoint : Point := {x := 5.1, y := 4.2}
def zeroedPoint := betterZeroX examplePoint
#eval examplePoint
#eval zeroX examplePoint
#eval betterZeroX examplePoint
#eval zeroedPoint
#eval betterZeroX ({x := 3.2, y := -1.5} : Point)

/-By default, the constructor for a structure named S is named S.mk. Here, S is
a namespace qualifier, and mk is the name of the constructor itself. Instead of
using curly-brace initialization syntax, the constructor can also be applied
directly.-/
def anotherExamplePoint := Point.mk 1.5 2.8
#check anotherExamplePoint
#check Point.mk 1.5 2.8
#check ({x := 1.5, y := 2.8} : Point)
/-Constructors have function types, which means they can be used anywhere that
a function is expected.-/
#check Point.mk
--Overriding a structure's constructor name

structure NewPoint where
  newpoint ::
  x : Float
  y : Float

#check ({x := 1.5, y := 2.8} : NewPoint)
def exampleNewPoint := NewPoint.newpoint 1.5 2.8
#check exampleNewPoint
#check NewPoint.newpoint 1.5 2.8
#check NewPoint.newpoint

--Accessor functions
#check Point.mk
#check Point.x
#check (Point.x)
#check (Point.x : Point → Float)
#check ((Point.x) : Point → Float)
--#check (Point.x (self : Point) : Float)
#eval origin.x
#eval Point.x origin

/-More generally, accessor notation has the form TARGET.f ARG1 ARG2 .... If
TARGET has type T, the function named T.f is called. TARGET becomes its
leftmost argument of type T, which is often but not always the first one, and
ARG1 ARG2 ... are provided in order as the remaining arguments.
Note: analogous to tensor contraction $ι_X(α) := α(X, ⋯)$.
-/
#eval String.append "one string" " and another"
#eval "one string".append " and another"

def Point.dotProduct (p1 : Point) (p2: Point) : Float :=
  (p1.x)*(p2.x) + (p1.y)*(p2.y)

def pointA := ({x := 1.0, y := 2.0} : Point)
def pointB := ({x := 3.0, y := -2.0} : Point)
--Direct call
#eval Point.dotProduct pointA pointB
--With accessor-style notation
#eval pointA.dotProduct pointB

def Point.modifyBoth (f : Float → Float) (p : Point) : Point :=
  {x := f p.x, y := f p.y}
def fourAndThree := ({x := 4.1, y := 3.1} : Point)
#eval Point.modifyBoth Float.floor fourAndThree
#eval fourAndThree.modifyBoth Float.floor
