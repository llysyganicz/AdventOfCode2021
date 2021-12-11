import 'dart:io';
import 'dart:math';

class Octopus {
  final int row;
  final int column;
  int powerLevel;
  int _flashesCount = 0;
  bool flashed = false;

  int get flashesCount => _flashesCount;

  Octopus(this.row, this.column, this.powerLevel);

  bool increasePowerLevel() {
    if (flashed) return false;

    powerLevel = (powerLevel + 1) % 10;

    if (powerLevel == 0) {
      ++_flashesCount;
      flashed = true;
      return true;
    }

    return false;
  }
}

void main() async {
  final lines = await File('input.txt').readAsLines();
  final octopuses = List<Octopus>.empty(growable: true);
  final rows = lines.length;
  final columns = lines.first.length;

  for (var row = 0; row < rows; row++) {
    for (var column = 0; column < columns; column++) {
      octopuses.add(Octopus(row, column, int.parse(lines[row][column])));
    }
  }

  for (var day = 0; day < 100; day++) {
    final stack = List<Octopus>.empty(growable: true);
    octopuses.forEach((octopus) {
      octopus.flashed = false;
      stack.addAll(increaseLevel(octopus, octopuses, rows, columns));
    });

    while (!stack.isEmpty) {
      final octopus = stack.first;
      stack.removeAt(0);
      stack.addAll(increaseLevel(octopus, octopuses, rows, columns));
    }
  }

  final flashesCount =
      octopuses.map((e) => e.flashesCount).reduce((v, e) => v + e);

  print(flashesCount);
}

List<Octopus> increaseLevel(
    Octopus octopus, List<Octopus> octopuses, int rows, int columns) {
  final stack = List<Octopus>.empty(growable: true);
  if (octopus.increasePowerLevel()) {
    final startColumn = max(0, octopus.column - 1);
    final endColumn = min(columns - 1, octopus.column + 1);
    final startRow = max(0, octopus.row - 1);
    final endRow = min(rows - 1, octopus.row + 1);
    for (var row = startRow; row <= endRow; row++) {
      for (var column = startColumn; column <= endColumn; column++) {
        if (octopus.row == row && octopus.column == column) continue;
        final toAdd =
            octopuses.firstWhere((o) => o.row == row && o.column == column);
        stack.add(toAdd);
      }
    }
  }
  return stack;
}
