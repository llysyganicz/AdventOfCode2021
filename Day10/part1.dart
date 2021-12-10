import 'dart:io';

void main() async {
  final lines = await File('input.txt').readAsLines();
  final score = lines.map((line) => getLineScore(line)).reduce((v, e) => v + e);

  print(score);
}

int getLineScore(String line) {
  final stack = List<String>.empty(growable: true);
  for (var i = 0; i < line.length; i++) {
    if (isOpenBracket(line[i])) {
      stack.add(line[i]);
    } else if (bracketsMatch(stack.last, line[i])) {
      stack.removeLast();
    } else {
      return getScore(line[i]);
    }
  }

  return 0;
}

final List<String> openBrackets = ['(', '[', '{', '<'];
bool isOpenBracket(String bracket) => openBrackets.contains(bracket);

bool bracketsMatch(String open, String close) {
  switch (open) {
    case '(':
      return close == ')';
    case '[':
      return close == ']';
    case '{':
      return close == '}';
    case '<':
      return close == '>';
    default:
      return false;
  }
}

int getScore(String bracket) {
  switch (bracket) {
    case ')':
      return 3;
    case ']':
      return 57;
    case '}':
      return 1197;
    case '>':
      return 25137;
    default:
      return 0;
  }
}
