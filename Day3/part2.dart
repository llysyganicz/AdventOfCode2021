import 'dart:io';

void main() {
  final binaries = File('input.txt').readAsLinesSync();
  List<String> oxygen = List.from(binaries);
  List<String> co2 = List.from(binaries);

  for (var i = 0; i < binaries[0].length; i++) {
    if (oxygen.length > 1) {
      final zerosCount = oxygen.where((e) => e[i] == '0').length;
      final onesCount = oxygen.where((e) => e[i] == '1').length;

      if (zerosCount > onesCount)
        oxygen = oxygen.where((e) => e[i] == '0').toList();
      else
        oxygen = oxygen.where((e) => e[i] == '1').toList();
    }

    if (co2.length > 1) {
      final zerosCount = co2.where((e) => e[i] == '0').length;
      final onesCount = co2.where((e) => e[i] == '1').length;

      if (zerosCount > onesCount)
        co2 = co2.where((e) => e[i] == '1').toList();
      else
        co2 = co2.where((e) => e[i] == '0').toList();
    }

    if (oxygen.length == 1 && co2.length == 1) break;
  }

  final result = int.parse(oxygen[0], radix: 2) * int.parse(co2[0], radix: 2);
  print(result);
}
