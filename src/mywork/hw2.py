from z3 import *

X, Y, Z = Bools("X Y Z")
s = Solver()

C1 = Implies(And(Or(X,Y),X),Not(Y))
# If X or Y is true, and X is true, then this entails that Y is not true.
# Not valid, CE: X = True, Y = True
# X = It is raining
# Y = It is wet
# It is raining or it is wet, and it is raining, so it is not wet.
# This doesn't make sense because when it is raining, it doesn't necessarily mean that it is not wet. It could be raining AND it could be wet. It is not exclusive to one or the other.
C2 = Implies(And(X, Y), And(X, Y))
# If X and Y is true, then this entails that X and Y is true
C3 = Implies(And(X, Y), X)
# If X and Y is true, then this entails that X is true
C4 = Implies(And(X, Y), Y)
# When X and Y is true, then it entails that Y is true
C5 = Implies(Not(Not(X)), X)
# When X is not not true, then it entails that X is true
C6 = Not(And(X, Not(X)))
# X and not X is not true
C7 = Implies(X, Or(X, Y))
# When X is true, then it entails that X or Y is true
C8 = Implies(Y, Or(X, Y))
# When Y is true, then it tails that X or Y is true
C9 = Implies(And(Implies(X, Y), Not(X)), Not(Y))
# If X is true, then it implies that Y is true, and not X entails not Y
# Not valid, CE: X = False, Y = True
# X = It is not raining
# Y = It is wet
# If it is not raining, then it is wet, and it is raining, so it is not wet.
# This doesn't make sense because it is wet because it is raining, so it can't be wet without it raining.
C10 = Implies(And(Implies(X, Y), Implies(Y, X)), (X==Y))
# When X is true, then it implies that Y is true, and Y implies that X is true, which entails that X is true if and only if Y is true
C11 = Implies((X==Y), Implies(X, Y))
# X is true if and only if Y is true, which entails the implication that if X is true, then Y is true
C12 = Implies((X == Y), Implies(Y, X))
# X is true if and only Y is true, which entails the implication that if Y is true, then X is true
C13 = Implies(And(Or(X, Y), Implies(X, Z), Implies(Y, Z)), Z)
# If X or Y is true, and X is true, then this implies that Z is true and if Y is true, then Z is true, which entails that Z is true
C14 = Implies(And(Implies(X, Y), Y), X)
# When X is true, it is implied that Y is true, and when Y is true, it entails that X is true
# Not valid, CE: X = False, Y = True
# X = It is not raining
# Y = It is wet
# It is not raining, so it is wet, and it is wet, so it entails that it is not raining.
# This doesn't make sense because it is wet since it is raining. It can't be wet if its not raining.
C15 = Implies(And(Implies(X, Y), X), Y)
# When X is true, it is implied that Y is true, and when X is true, it entails that Y is true
C16 = Implies(And(Implies(X, Z), Implies(Y, Z)), Implies(X, Z))
# When X is true, it is implied that Y is true, and when Y is true, it is implied that X is true, which entails the implication that when X is true, Z is true
C17 = Implies(Implies(X, Y), Implies(Y, X))
# When X is true, it is implied that Y is true, which entails the implication that when Y is true, X is true
# Not valid, CE: X = False, Y = True
# X = It is not raining
# Y = It is wet
# It is not raining, so it is wet, which entails that it is wet, so it is not raining.
# This doesn't make sense because it is wet because it is raining, so if it is not raining, then it can't be wet.
C18 = Implies(Implies(X, Y), Implies(Not(Y), Not(X)))
# When X is true, it is implied that Y is true, which entails that not Y implies not X.
C19 = (Not(Or(X, Y)) == And(Not(X), Not(Y)))
# Not X or Y is true if and only if not X and not Y
C20 = (Not(And(X, Y)) == Or(Not(X), Not(Y))) 
# Not X and Y is true if and only if not X or not Y

def isValid(name, exp):
    r = ''
    s.add(Not(exp))
    if s.check() == unsat:
        r = f'{name} is valid'
    else:
        r = f'{name} is not valid. Counter example: {s.model()}'
    s.reset()
    return r

print(isValid('C1', C1))
# Not valid

print(isValid('C2', C2))
# Valid

print(isValid('C3', C3))
# Valid

print(isValid('C4', C4))
# Valid

print(isValid('C5', C5))
# Valid

print(isValid('C6', C6))
# Not valid

print(isValid('C7', C7))
# Valid

print(isValid('C8', C8))
# Valid

print(isValid('C9', C9))
# Valid

print(isValid('C10', C10))
# Valid

print(isValid('C11', C11))
# Valid

print(isValid('C12', C12))
# Valid

print(isValid('C13', C13))
# Valid

print(isValid('C14', C14))
# Not valid

print(isValid('C15', C15))
# Valid

print(isValid('C16', C16))
# Valid

print(isValid('C17', C17))
# Valid

print(isValid('C18', C18))
# Valid

print(isValid('C19', C19))
# Not valid

print(isValid('C20', C20))
# Valid