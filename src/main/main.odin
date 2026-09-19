package main

import "core:fmt"
import "core:time"
import "../sudoku"

sample_puzzle := sudoku.Board{
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

main :: proc() {
	board := sample_puzzle

	fmt.println("=== Puzzle ===")
	sudoku.print_board(&board)
	fmt.println()

	start := time.now()
	ok := sudoku.solve(&board)
	elapsed := time.since(start)

	if !ok {
		fmt.println("No solution exists for this puzzle.")
		return
	}

	fmt.println("=== Solved ===")
	sudoku.print_board(&board)
	fmt.printfln("\nSolved %d cells in %v", sudoku.count_filled(&board), elapsed)

	if !sudoku.is_complete(&board) {
		fmt.println("WARNING: solution failed validation (this should never happen).")
	}
}
