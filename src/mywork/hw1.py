# Tony Tran
# ymn4ar@virginia.edu

from z3 import Bool, And, Or, Not, Solver
from itertools import combinations


def at_most_one(literals):
    c = []
    for pair in combinations(literals, 2):
        a, b = pair[0], pair[1]
        c += [Or(Not(a), Not(b))]
    return And(c)

# Create literals
x = [[Bool("x_%i+%i" % (i, j)) for j in range(5)] for i in range(5)]

# Solver instance
s = Solver()

# Add constraints

# 5 queens
for i in range(5):
    s.add(Or(x[i]))
    
# At most 1 queen per row
# at most 1 queen per col
for i in range(5):
    col = []
    for j in range(5):
        col+= [x[j][i]]
    s.add(at_most_one(col))
    s.add(at_most_one(x[i]))
    
# at most 1 queen per diag
for i in range(4):
    diag_1 = []
    diag_2 = []
    diag_3 = []
    diag_4 = []
    for j in range(5-i):
        diag_1 += [x[i+j][j]]
        diag_2 += [x[i+j][4-j]]
        diag_3 += [x[4-(i+j)][j]]
        diag_4 += [x[4-(i+j)][4-j]]
    s.add(at_most_one(diag_1))
    s.add(at_most_one(diag_2))
    s.add(at_most_one(diag_3))
    s.add(at_most_one(diag_4))
    
print(s.check())
m = s.model()

for i in range(5):
    line = ""
    for j in range(5):
        if m.evaluate(x[i][j]):
            line += "X "
        else:
            line += ". "
    print(line)