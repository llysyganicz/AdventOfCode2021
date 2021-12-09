import 'dart:io';

class Cell {
  final int row;
  final int column;
  final int value;

  Cell(this.row, this.column, this.value);
}

enum Direction { left, top, right, bottom }

void main() async {
  final lines = (await File('input.txt').readAsLines());
  final rows = lines.length;
  final columns = lines.first.length;
  final grid = List<Cell>.empty(growable: true);
  for (int row = 0; row < rows; row++) {
    final values = lines[row].split('').map((e) => int.parse(e)).toList();
    for (var column = 0; column < columns; column++) {
      grid.add(Cell(row, column, values[column]));
    }
  }

  final result = grid
      .where((e) => isLowPoint(e, grid, rows, columns))
      .map((e) => e.value + 1)
      .reduce((v, e) => v + e);

  print(result);
}

bool isLowPoint(Cell cell, List<Cell> grid, int rows, int columns) {
  if (cell.value == 9) return false;

  final left = isLower(cell, grid, Direction.left, rows, columns);
  final top = isLower(cell, grid, Direction.top, rows, columns);
  final right = isLower(cell, grid, Direction.right, rows, columns);
  final bottom = isLower(cell, grid, Direction.bottom, rows, columns);

  return left && top && right && bottom;
}

bool isLower(
    Cell cell, List<Cell> grid, Direction direction, int rows, int columns) {
  int row = cell.row;
  int column = cell.column;
  switch (direction) {
    case Direction.left:
      if (column == 0) return true;
      --column;
      break;
    case Direction.top:
      if (row == 0) return true;
      --row;
      break;
    case Direction.right:
      if (column == columns - 1) return true;
      ++column;
      break;
    case Direction.bottom:
      if (row == rows - 1) return true;
      ++row;
      break;
  }

  final value =
      grid.firstWhere((e) => e.column == column && e.row == row).value;

  return value > cell.value;
}
