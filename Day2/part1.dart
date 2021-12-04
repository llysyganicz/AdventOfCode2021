import 'dart:io';

void main() {
  final commands = File('input.txt').readAsLinesSync().toList();
  final forward = commands.where((cmd) => cmd.startsWith('forward')).map((e) => getDistance(e)).reduce((v, e) => v + e);
  final down = commands.where((cmd) => cmd.startsWith('down')).map((e) => getDistance(e)).reduce((v, e) => v + e);
  final up = commands.where((cmd) => cmd.startsWith('up')).map((e) => getDistance(e)).reduce((v, e) => v + e);
  final result = forward * (down - up);
  print(result);
}

int getDistance(String command) {
  return int.parse(command.split(' ')[1]);
}