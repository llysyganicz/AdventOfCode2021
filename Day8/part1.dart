import 'dart:io';

void main() {
  final digits = File('input.txt')
      .readAsLinesSync()
      .map((e) => e.split('|')[1].trim().split(' '))
      .expand((e) => e)
      .toList();

  final count = digits
      .where((e) =>
          e.length == 2 || e.length == 3 || e.length == 4 || e.length == 7)
      .length;
  print(count);
}
