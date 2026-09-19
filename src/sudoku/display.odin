package sudoku

import "core:fmt"
import "core:strings"

// print_board renders the grid with box separators, e.g.:
//   5 3 . | . 7 . | . . .
//   6 . . | 1 9 5 | . . .
//   ------+-------+------
print_board :: proc(board: ^Board) {
	sb := strings.builder_make()
	defer strings.builder_destroy(&sb)

	for r in 0 ..< 9 {
		if r > 0 && r % 3 == 0 {
			strings.write_string(&sb, "------+-------+------\n")
		}
		for c in 0 ..< 9 {
			if c > 0 && c % 3 == 0 {
				strings.write_string(&sb, "| ")
			}
			val := board[r][c]
			if val == 0 {
				strings.write_string(&sb, ". ")
			} else {
				strings.write_int(&sb, val)
				strings.write_string(&sb, " ")
			}
		}
		strings.write_string(&sb, "\n")
	}

	fmt.print(strings.to_string(sb))
}
