import 'dart:io';
import 'package:collection/collection.dart';

class Cell {
  final row;
  final column;
  final value;
  bool marked = false;

  Cell(this.row, this.column, this.value);
}

class Board {
  final cells = List<Cell>.empty(growable: true);

  bool isWinner() {
    for (var i = 1; i <= 5; i++) {
      var rowWin =
          cells.where((cell) => cell.row == i && cell.marked).length == 5;
      var columnWin =
          cells.where((cell) => cell.column == i && cell.marked).length == 5;
      if (rowWin || columnWin) return true;
    }
    return false;
  }

  void mark(int number) {
    cells
        .where((cell) => cell.value == number)
        .forEach((cell) => cell.marked = true);
  }

  int calculateScore(int number) {
    return cells.where((cell) => !cell.marked).map((cell) => cell.value).reduce((v, e) => v + e) * number;
  }
}

void main() {
  final lines = File('input.txt').readAsLinesSync();
  var numbers = lines[0].split(',').map((e) => int.parse(e)).toList();
  final boards = List<Board>.empty(growable: true);

  setup(lines, boards);

  numbers.take(5).forEach((number) { 
    markBoards(boards, number);
  });

  numbers = numbers.skip(5).toList();
  Board? winner = getWinnerBoard(boards);
  var currentNumber = 0;
  while(winner == null) {
    currentNumber = numbers.first;
    markBoards(boards, currentNumber);
    winner = getWinnerBoard(boards);
    numbers = numbers.skip(1).toList();
  }

  print(winner.calculateScore(currentNumber));
}

void setup(List<String> lines, List<Board> boards) {
  var row = 1;
  for (var i = 1; i < lines.length; i++) {
    if (lines[i].length == 0) {
      boards.add(Board());
      row = 1;
      continue;
    }

    final board = boards.last;
    final values = lines[i].split(' ').where((e) => e.length > 0).map((e) => int.parse(e)).toList();
    for (var c = 0; c < values.length; c++) {
      board.cells.add(Cell(row, c + 1, values[c]));
    }

    ++row;
  }
}

Board? getWinnerBoard(List<Board> boards) {
  return boards.firstWhereOrNull((board) => board.isWinner());
}

void markBoards(List<Board> boards, int number) {
  boards.forEach((board) => board.mark(number));
}