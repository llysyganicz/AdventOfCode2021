import 'dart:io';
import 'dart:math';

void main() {
  final result = File('input.txt')
      .readAsLinesSync()
      .map((e) => parseLine(e))
      .reduce((v, e) => v + e);
  print(result);
}

int parseLine(String line) {
  final splittedLine = line.split('|');
  final digits = splittedLine[0].trim().split(' ');
  final mapping = prepareMapping(digits);

  return decodeNumber(splittedLine[1], mapping);
}

Map<int, String> prepareMapping(List<String> digits) {
  final mapping = Map<int, String>();
  mapping.putIfAbsent(1, () => digits.firstWhere((e) => e.length == 2));
  mapping.putIfAbsent(4, () => digits.firstWhere((e) => e.length == 4));
  mapping.putIfAbsent(7, () => digits.firstWhere((e) => e.length == 3));
  mapping.putIfAbsent(8, () => digits.firstWhere((e) => e.length == 7));

  mapping.forEach((key, value) => digits.remove(value));

  mapping.putIfAbsent(
      3, () => digits.firstWhere((e) => isThree(e, mapping[1]!)));
  digits.remove(mapping[3]!);

  mapping.putIfAbsent(6, () => digits.firstWhere((e) => isSix(e, mapping[1]!)));
  digits.remove(mapping[6]!);

  mapping.putIfAbsent(
      9, () => digits.firstWhere((e) => isNine(e, mapping[3]!)));
  digits.remove(mapping[9]!);

  mapping.putIfAbsent(0, () => digits.firstWhere((e) => e.length == 6));
  digits.remove(mapping[0]!);

  mapping.putIfAbsent(
      5, () => digits.firstWhere((e) => isFive(e, mapping[6]!)));
  digits.remove(mapping[5]!);

  mapping.putIfAbsent(2, () => digits.first);

  return mapping;
}

bool isThree(String digit, String one) {
  final oneChars = one.split('');
  return digit.length == 5 &&
      digit.contains(oneChars[0]) &&
      digit.contains(oneChars[1]);
}

bool isFive(String digit, String six) {
  final digitChars = digit.split('');
  return digit.length == 5 && !digitChars.any((e) => !six.contains(e));
}

bool isSix(String digit, String one) {
  final oneChars = one.split('');
  return digit.length == 6 &&
      ((digit.contains(oneChars[0]) && !digit.contains(oneChars[1])) ||
          (digit.contains(oneChars[1]) && !digit.contains(oneChars[0])));
}

bool isNine(String digit, String three) {
  final threeChars = three.split('');
  return digit.length == 6 && !threeChars.any((e) => !digit.contains(e));
}

int decodeNumber(String input, Map<int, String> mapping) {
  final digits = input.trim().split(' ').map((e) => e.trim()).toList();
  int number = 0;
  for (int i = 0; i < 4; i++) {
    final digit = mapping.entries
        .firstWhere((e) => sortLetters(e.value) == sortLetters(digits[i]))
        .key;
    number += digit * (pow(10, 3 - i)).toInt();
  }

  return number;
}

String sortLetters(String word) {
  final letters = word.split('');
  letters.sort();
  return letters.join();
}
