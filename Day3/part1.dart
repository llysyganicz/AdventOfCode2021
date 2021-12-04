import 'dart:io';

void main() {
  final binaries = File('input.txt').readAsLinesSync();
  String gamma = "";
  String epsilon = "";

  for (var i = 0; i < binaries[0].length; i++) {
    final zerosCount = binaries.where((e) => e[i] == '0').length;
    final onesCount = binaries.where((e) => e[i] == '1').length;

    if(zerosCount > onesCount) {
      gamma += '0';
      epsilon += '1';
    }
    else {
      gamma += '1';
      epsilon += '0';
    }
  }

  final result = int.parse(gamma, radix: 2) * int.parse(epsilon, radix: 2);
  print(result);
}