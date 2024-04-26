def solve_sudoku(board):
  """
  با استفاده از رهیابی معکوس، یک مسأله‌ی سودوکو را حل می‌کند.

  Args:
      board: یک لیست از لیست‌های 9x9 که نماینده‌ی تخته‌ی سودوکو است.

  Returns:
      True اگر مسأله حل شود، در غیر این صورت False.
  """
  find = find_empty(board)
  if not find:
    return True
  row, col = find

  for num in range(1, 10):
    if is_valid(board, row, col, num):
      board[row][col] = num

      if solve_sudoku(board):
        return True

      board[row][col] = 0

  return False

def find_empty(board):
  """
  یک خانه خالی در تخته‌ی سودوکو پیدا می‌کند.

  Args:
      board: یک لیست از لیست‌های 9x9 که نماینده‌ی تخته‌ی سودوکو است.

  Returns:
      یک تاپل شامل شماره ردیف و ستون خانه‌ی خالی، یا در صورت عدم وجود خانه خالی، None.
  """
  for i in range(len(board)):
    for j in range(len(board[0])):
      if board[i][j] == 0:
        return (i, j)
  return None

def is_valid(board, row, col, num):
  """
  بررسی می‌کند که قرار دادن یک عدد در یک خانه، با قوانین سودوکو سازگار است یا خیر.

  Args:
      board: یک لیست از لیست‌های 9x9 که نماینده‌ی تخته‌ی سودوکو است.
      row: شماره ردیف خانه.
      col: شماره ستون خانه.
      num: عددی که باید در خانه قرار داده شود.

  Returns:
      True اگر قرار دادن عدد معتبر باشد، در غیر این صورت False.
  """
  # بررسی ردیف
  for i in range(len(board)):
    if board[i][col] == num and i != row:
      return False

  # بررسی ستون
  for j in range(len(board[0])):
    if board[row][j] == num and j != col:
      return False

  # بررسی زیرتخته
  start_row = row - row % 3
  start_col = col - col % 3
  for i in range(start_row, start_row + 3):
    for j in range(start_col, start_col + 3):
      if board[i][j] == num and (i, j) != (row, col):
        return False

  return True

# نمونه استفاده
board = [
  [0, 0, 0, 0, 9, 4, 0, 3, 0],
  [0, 0, 0, 5, 1, 0, 0, 0, 7],
  [0, 8, 9, 0, 0, 0, 0, 4, 0],
  [0, 0, 0, 0, 0, 0, 2, 0, 8],
  [0, 6, 0, 2, 0, 1, 0, 5, 0],
  [1, 0, 2, 0, 0, 0, 0, 0, 0],
  [0, 7, 0, 0, 0, 0, 5, 2, 0],
  [9, 0, 0, 0, 6, 5, 0, 0, 0],
  [0, 4, 0, 9, 7, 0, 0, 0, 0]
]

if solve_sudoku(board):
  print("Sudoku Solved!")
  for i in board:
    print(i)
else:
  print("No solution found")
