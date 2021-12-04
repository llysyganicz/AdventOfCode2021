import 'dart:io';

void main() {
  final measurements = File('input.txt').readAsLinesSync().map((e) => int.parse(e)).toList();
  final windowed = window(measurements, 3);
  final sums = windowed.map((e) => e.reduce((v, e) => v + e)).toList();
  final pairs = window(sums, 2);
  final count = pairs.where((e) => e[1] - e[0] > 0).length;
  print(count);
}

List<List<int>> window(List<int> list, int size) {
  final List<List<int>> innerList = List.empty(growable: true);

  for (var i = 0; i < list.length; i++) {
    if (i + size - 1 < list.length) {
      innerList.add(list.sublist(i, i + size));
    }
  }

  return innerList;
}
