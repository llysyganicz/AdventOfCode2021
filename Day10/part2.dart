import 'dart:io';

void main() async {
  final lines = await File('input.txt').readAsLines();
  final scores = lines
      .where((line) => isValidLine(line))
      .map((line) => getLineScore(line))
      .toList();

  scores.sort();

  print(scores[scores.length ~/ 2]);
}

bool isValidLine(String line) {
  final stack = List<String>.empty(growable: true);
  for (var i = 0; i < line.length; i++) {
    if (isOpenBracket(line[i])) {
      stack.add(line[i]);
    } else if (bracketsMatch(stack.last, line[i])) {
      stack.removeLast();
    } else {
      return false;
    }
  }

  return true;
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

int getLineScore(String line) {
  final stack = List<String>.empty(growable: true);
  for (var i = 0; i < line.length; i++) {
    if (isOpenBracket(line[i])) {
      stack.add(line[i]);
    } else if (bracketsMatch(stack.last, line[i])) {
      stack.removeLast();
    }
  }

  return getScore(stack);
}

final bracketScores = {'(': 1, '[': 2, '{': 3, '<': 4};
int getScore(List<String> incompleteBrackets) {
  int score = 0;
  while (!incompleteBrackets.isEmpty) {
    score *= 5;
    score += bracketScores[incompleteBrackets.last]!;
    incompleteBrackets.removeLast();
  }

  return score;
}
