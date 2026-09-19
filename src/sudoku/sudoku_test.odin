package sudoku

import "core:testing"

@(test)
test_solve_easy_puzzle :: proc(t: ^testing.T) {
	board := Board{
		{5, 3, 0, 0, 7, 0, 0, 0, 0},
		{6, 0, 0, 1, 9, 5, 0, 0, 0},
		{0, 9, 8, 0, 0, 0, 0, 6, 0},
		{8, 0, 0, 0, 6, 0, 0, 0, 3},
		{4, 0, 0, 8, 0, 3, 0, 0, 1},
		{7, 0, 0, 0, 2, 0, 0, 0, 6},
		{0, 6, 0, 0, 0, 0, 2, 8, 0},
		{0, 0, 0, 4, 1, 9, 0, 0, 5},
		{0, 0, 0, 0, 8, 0, 0, 7, 9},
	}

	ok := solve(&board)
	testing.expect(t, ok, "expected puzzle to be solvable")
	testing.expect(t, count_filled(&board) == 81, "expected all 81 cells filled")
	testing.expect(t, is_complete(&board), "expected a fully valid solved board")
}

@(test)
test_is_valid_detects_row_conflict :: proc(t: ^testing.T) {
	board := Board{}
	board[0][0] = 5
	testing.expect(t, !is_valid(&board, 0, 4, 5), "expected row conflict to be detected")
}

@(test)
test_is_valid_detects_column_conflict :: proc(t: ^testing.T) {
	board := Board{}
	board[0][0] = 5
	testing.expect(t, !is_valid(&board, 4, 0, 5), "expected column conflict to be detected")
}

@(test)
test_is_valid_detects_box_conflict :: proc(t: ^testing.T) {
	board := Board{}
	board[0][0] = 7
	testing.expect(t, !is_valid(&board, 1, 1, 7), "expected 3x3 box conflict to be detected")
}

@(test)
test_unsolvable_puzzle_returns_false :: proc(t: ^testing.T) {
	board := Board{}
	// Two 5s in the same row makes this unsolvable from the start.
	board[0][0] = 5
	board[0][1] = 5

	ok := solve(&board)
	testing.expect(t, !ok, "expected an already-contradictory puzzle to fail")
}

@(test)
test_find_empty_returns_first_zero :: proc(t: ^testing.T) {
	board := Board{}
	board[0][0] = 1
	row, col, found := find_empty(&board)
	testing.expect(t, found, "expected an empty cell to be found")
	testing.expect(t, row == 0 && col == 1, "expected first empty cell at (0,1)")
}
