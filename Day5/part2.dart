import 'dart:io';
import 'dart:math';

class Field {
  final int x;
  final int y;

  Field(this.x, this.y);

  bool operator ==(Object other) =>
      other is Field && x == other.x && y == other.y;

  int get hashCode => Object.hash(x, y);

  String toString() {
    return "($x, $y)";
  }
}

class Vent {
  final Field start;
  final Field end;

  Vent(this.start, this.end);

  List<Field> getFields() {
    final result = List<Field>.empty(growable: true);

    if (start.x == end.x) {
      final lower = min(start.y, end.y);
      final upper = max(start.y, end.y);
      for (var i = lower; i <= upper; i++) {
        result.add(Field(start.x, i));
      }
    } else if (start.y == end.y) {
      final lower = min(start.x, end.x);
      final upper = max(start.x, end.x);
      for (var i = lower; i <= upper; i++) {
        result.add(Field(i, start.y));
      }
    } else if (isDiagonal()) {
      if (start.x < end.x) {
        final sign = start.y - end.y > 0 ? -1 : 1;
        for (var i = 0; i <= end.x - start.x; i++) {
          result.add(Field(start.x + i, start.y + i * sign));
        }
      }
      else {
        final sign = end.y - start.y > 0 ? -1 : 1;
        for (var i = 0; i <= start.x - end.x; i++) {
          result.add(Field(end.x + i, end.y + i * sign));
        }
      }
    }

    return result;
  }

  bool isDiagonal() {
    final xLength = (start.x - end.x).abs();
    final yLenght = (start.y - end.y).abs();
    return xLength == yLenght;
  }
}

void main() {
  final lines = File('input.txt').readAsLinesSync();
  final vents = getVents(lines);
  var fields = Map();
  vents.forEach((vent) {
    final ventFields = vent.getFields();
    ventFields.forEach((field) {
      if (fields.containsKey(field))
        fields[field] += 1;
      else
        fields.putIfAbsent(field, () => 1);
    });
  });

  final count = fields.values.where((v) => v > 1).length;
  print(count);
}

List<Vent> getVents(List<String> lines) {
  final vents = List<Vent>.empty(growable: true);
  lines.forEach((line) {
    final splittedLine = line.split(' -> ');
    if (splittedLine.length != 2) return;
    final start = splittedLine[0].split(',');
    final end = splittedLine[1].split(',');
    final startField = Field(int.parse(start[0]), int.parse(start[1]));
    final endField = Field(int.parse(end[0]), int.parse(end[1]));
    vents.add(Vent(startField, endField));
  });

  return vents;
}
