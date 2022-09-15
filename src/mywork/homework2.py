from z3 import *

def hw2():
    X, Y, Z = Bools("X Y Z")
    s = Solver()
	

    C1 = Implies(And(Or(X, Y), X), Not(Y))
 
    s.add(Not(C1))
    r = s.check()

    if (r == unsat):
        print("C1 is valid")
    else:
        print("Counter example: ", s.model())
  
hw2()