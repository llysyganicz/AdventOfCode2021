import 'dart:io';
import 'package:collection/collection.dart';

void main() async {
  Map<int, int> fishes = (await File('input.txt').readAsString())
      .split(',')
      .map((e) => int.parse(e.trim()))
      .groupListsBy((e) => e, ).map((key, value) => MapEntry(key, value.length));

  for (var i = 0; i < 256; i++) {
    fishes = cycleDay(fishes);
  }

  print(fishes.values.sum);
}


Map<int, int> cycleDay(Map<int, int> fishes) {
  final result = Map<int, int>();
  result.putIfAbsent(8, () => fishes[0] ?? 0);
  result.putIfAbsent(7, () => fishes[8] ?? 0);
  result.putIfAbsent(6, () => (fishes[0] ?? 0) + (fishes[7] ?? 0));
  result.putIfAbsent(5, () => fishes[6] ?? 0);
  result.putIfAbsent(4, () => fishes[5] ?? 0);
  result.putIfAbsent(3, () => fishes[4] ?? 0);
  result.putIfAbsent(2, () => fishes[3] ?? 0);
  result.putIfAbsent(1, () => fishes[2] ?? 0);
  result.putIfAbsent(0, () => fishes[1] ?? 0);

  return result;
}