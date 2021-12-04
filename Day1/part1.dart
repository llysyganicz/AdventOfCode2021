import 'dart:io';

void main() {
  final measurements = File('input.txt').readAsLinesSync().map((e) => int.parse(e)).toList();
  final pairs = createPairs(measurements);
  final count = pairs.where((e) => e[1] - e[0] > 0).length;
  print(count);
}

List<List<int>> createPairs(List<int> list) {
  final List<List<int>> pairs = List.empty(growable: true);
  
  for (var i = 0; i < list.length; i++) {
    if (i + 1 < list.length) {
      pairs.add([list[i], list[i + 1]]);
    }
  }

  return pairs;
}