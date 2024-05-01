from z3 import *

def solve_sudoku(puzzle):
    # ایجاد یک نمونه از راه‌حل‌گر Z3
    solver = Solver()

    # تعریف شبکه
    grid = [[Int(f"cell_{i}_{j}") for j in range(9)] for i in range(9)]

    # افزودن محدودیت برای هر خانه
    for i in range(9):
        for j in range(9):
            # افزودن محدودیت‌ها برای خانه‌هایی که مقدار مشخصی دارند
            if puzzle[i][j] != 0:
                solver.add(grid[i][j] == puzzle[i][j])
            
            # افزودن محدودیت‌ها برای هر ردیف
            solver.add(Distinct(grid[i]))

            # افزودن محدودیت‌ها برای هر ستون
            solver.add(Distinct([grid[x][j] for x in range(9)]))

            # افزودن محدودیت‌ها برای هر زیرشبکه 3x3
            subgrid_start_i, subgrid_start_j = 3 * (i // 3), 3 * (j // 3)
            solver.add(Distinct([grid[x][y] for x in range(subgrid_start_i, subgrid_start_i + 3) 
                                             for y in range(subgrid_start_j, subgrid_start_j + 3)]))
    
    # بررسی اینکه آیا پازل قابل حل است یا خیر
    if solver.check() == sat:
        model = solver.model()
        solution = [[model.evaluate(grid[i][j]).as_long() for j in range(9)] for i in range(9)]
        return solution
    else:
        return None

# پازل نمونه (عدد 0 نشان‌دهنده خانه‌های خالی است)
puzzle = [
    [0, 0, 0, 0, 6, 1, 0, 0, 2],
    [0, 7, 0, 0, 0, 0, 0, 0, 0],
    [9, 2, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 4, 5, 2, 0, 9, 0, 0],
    [0, 8, 2, 1, 0, 4, 6, 3, 0],
    [0, 0, 3, 0, 7, 6, 1, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 9, 8],
    [0, 0, 0, 0, 0, 0, 0, 4, 0],
    [6, 0, 0, 3, 8, 0, 0, 0, 0]
]

solution = solve_sudoku(puzzle)
if solution:
    print("پازل سودوکو با موفقیت حل شد:")
    for row in solution:
        print(row)
else:
    print("برای پازل سودوکو داده شده هیچ راه‌حلی وجود ندارد.")
