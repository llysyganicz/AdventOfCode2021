import 'dart:io';
import 'package:collection/collection.dart';

void main() async {
  final positions = (await File('input.txt').readAsString())
      .split(',')
      .map((e) => int.parse(e.trim()))
      .toList();
  positions.sort();

  int fuelCost = -1;
  for (int i = positions.first; i <= positions.last; i++) {
    final costForPosition = positions.map((e) => calculateFuelCost(e, i)).sum;
    if (fuelCost == -1 || costForPosition < fuelCost) {
      fuelCost = costForPosition;
    }
  }

  print(fuelCost);
}

int calculateFuelCost(int startPosition, int endPosition) {
  final distance = (startPosition - endPosition).abs();
  return distance * (1 + distance) ~/ 2;
}
