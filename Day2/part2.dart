import 'dart:io';

void main() {
  final commands = File('input.txt').readAsLinesSync().map((e) => parseLine(e));
  int forward = 0;
  int aim = 0;
  int depth = 0;
  commands.forEach((cmd) {
    if (cmd.direction == 'forward') {
      forward += cmd.value;
      depth += aim * cmd.value;
    } else if (cmd.direction == 'down')
      aim += cmd.value;
    else
      aim -= cmd.value;
  });
  final result = forward * depth;
  print(result);
}

Command parseLine(String line) {
  final splittedLine = line.split(' ');
  return Command(splittedLine[0], int.parse(splittedLine[1]));
}

class Command {
  final String direction;
  final int value;

  Command(this.direction, this.value);
}

// fun processLines(lines: Sequence<String>): Int {
//   var forward = 0
//   var aim = 0
//   var depth = 0
//   lines.forEach {
//     val (direction, units) = parseLine(it)
//     when (direction) {
//       "forward" -> { 
//         forward += units
//         depth += aim * units
//       }
//       "down" -> aim += units
//       "up" -> aim -= units
//     }
//   }
//   return forward * depth
// }

// val inputStream: InputStream = File("input.txt").inputStream()

// val result = inputStream.bufferedReader().useLines { processLines(it) }

// println(result)
