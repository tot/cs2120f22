# Tony Tran
# ymn4ar@virignia.edu

from z3 import *
s = Solver()

grid = [[Int(f'cell_{r}_{c}') for c in range(9)] for r in range(9)]

for r in range(9):
    for c in range(9):
        s.add(grid[r][c] >= 1)
        s.add(grid[r][c] <=9)
    s.add(Distinct(grid[r]))

for c in range(9):
    s.add(Distinct([grid[r][c] for r in range(9)]))
    
for x in range(3):
    for y in range(3):
        s.add(Distinct([
			grid[x*3][y*3],
			grid[x*3][y*3+1],
			grid[x*3][y*3+2],
			grid[x*3+1][y*3],
			grid[x*3+1][y*3+1],
			grid[x*3+1][y*3+2],
			grid[x*3+2][y*3],
			grid[x*3+2][y*3+1],
			grid[x*3+2][y*3+2]
		]))

puzzle = [
'4..7.25..',
'9...5....',
'.214...98',
'2....7...',
'.6..2..4.',
'...5....7',
'83...615.',
'....1...3',
'..49.5..2',
]

for r in range(9):
    for c in range(9):
        n = puzzle[r][c]
        if n != '.':
            s.add(grid[r][c] == int(n))

s.check()
print(s.check())
m = s.model()

for r in range(9):
    print(''.join(str(m.eval(grid[r][c])) for c in range(9)))
    if r % 3 == 2:
        print('-' * 9)