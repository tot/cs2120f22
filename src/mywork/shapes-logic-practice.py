from z3 import *

# square = Real("square")
# circle = Real("circle")
# triangle = Real("triangle")

circle, triangle, square = Reals('circle triangle square')

eqOne = (square + circle + triangle == 10)
eqTwo = (circle + square - triangle == 6)
eqThree = (circle + triangle - square == 4)
eq = And(eqOne, eqTwo, eqThree)

s = Solver()
s.add(eq)

isSat = s.check()

if (isSat == sat):
    print(s.model())
else:
    print("no solution")

