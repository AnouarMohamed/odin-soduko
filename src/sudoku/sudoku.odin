package sudoku

// Board is a 9x9 grid; 0 represents an empty cell.
Board :: [9][9]int

// is_valid reports whether placing `num` at (row, col) breaks row, column,
// or 3x3 box constraints.
is_valid :: proc(board: ^Board, row, col, num: int) -> bool {
	for i in 0 ..< 9 {
		if board[row][i] == num do return false
		if board[i][col] == num do return false
	}

	box_row := (row / 3) * 3
	box_col := (col / 3) * 3
	for r in box_row ..< box_row + 3 {
		for c in box_col ..< box_col + 3 {
			if board[r][c] == num do return false
		}
	}

	return true
}

// find_empty returns the first empty cell in row-major order, if any.
find_empty :: proc(board: ^Board) -> (row, col: int, found: bool) {
	for r in 0 ..< 9 {
		for c in 0 ..< 9 {
			if board[r][c] == 0 {
				return r, c, true
			}
		}
	}
	return 0, 0, false
}

// solve fills `board` in place using recursive backtracking.
// Returns false if the puzzle has no solution.
solve :: proc(board: ^Board) -> bool {
	row, col, found := find_empty(board)
	if !found {
		return true // no empty cells left: solved
	}

	for num in 1 ..= 9 {
		if is_valid(board, row, col, num) {
			board[row][col] = num
			if solve(board) {
				return true
			}
			board[row][col] = 0 // backtrack
		}
	}

	return false
}

// count_filled counts non-zero cells, useful for sanity-checking a solve.
count_filled :: proc(board: ^Board) -> int {
	count := 0
	for r in 0 ..< 9 {
		for c in 0 ..< 9 {
			if board[r][c] != 0 {
				count += 1
			}
		}
	}
	return count
}

// is_complete reports whether every cell is filled and every constraint holds.
is_complete :: proc(board: ^Board) -> bool {
	for r in 0 ..< 9 {
		for c in 0 ..< 9 {
			val := board[r][c]
			if val == 0 {
				return false
			}
			board[r][c] = 0
			ok := is_valid(board, r, c, val)
			board[r][c] = val
			if !ok {
				return false
			}
		}
	}
	return true
}
