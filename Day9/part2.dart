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

  final lowPoints =
      grid.where((e) => isLowPoint(e, grid, rows, columns)).toList();
  final basins =
      lowPoints.map((e) => getBasin(e, grid, rows, columns)).toList();
  basins.sort((a, b) => a.length.compareTo(b.length));
  final result = basins.reversed
      .take(3)
      .map((e) => e.length)
      .fold(1, (int v, int e) => v * e);

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

List<Cell> getBasin(Cell lowPoint, List<Cell> grid, int rows, int columns) {
  final basin = List<Cell>.empty(growable: true);
  final cellsToCheck = List<Cell>.empty(growable: true);
  cellsToCheck.add(lowPoint);

  while (!cellsToCheck.isEmpty) {
    basin.add(cellsToCheck.first);
    cellsToCheck.addAll(grow(cellsToCheck.first, grid, rows, columns));
    cellsToCheck.removeWhere(
        (e) => basin.any((b) => b.column == e.column && b.row == e.row));
  }

  return basin;
}

List<Cell> grow(Cell cell, List<Cell> grid, int rows, int columns) {
  final cells = List<Cell>.empty(growable: true);
  if (cell.row - 1 >= 0) {
    final topCell = grid
        .firstWhere((e) => e.row == cell.row - 1 && e.column == cell.column);
    if (topCell.value != 9) cells.add(topCell);
  }
  if (cell.row + 1 < rows) {
    final bottomCell = grid
        .firstWhere((e) => e.row == cell.row + 1 && e.column == cell.column);
    if (bottomCell.value != 9) cells.add(bottomCell);
  }
  if (cell.column - 1 >= 0) {
    final leftCell = grid
        .firstWhere((e) => e.row == cell.row && e.column == cell.column - 1);
    if (leftCell.value != 9) cells.add(leftCell);
  }
  if (cell.column + 1 < columns) {
    final rightCell = grid
        .firstWhere((e) => e.row == cell.row && e.column == cell.column + 1);
    if (rightCell.value != 9) cells.add(rightCell);
  }

  return cells;
}
