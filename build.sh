#!/usr/bin/env bash
set -euo pipefail

mkdir -p bin
odin build src/main -out:bin/sudoku -o:speed

echo "Built bin/sudoku"
echo "Run it with: ./bin/sudoku"
