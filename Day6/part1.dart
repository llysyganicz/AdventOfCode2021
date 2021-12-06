import 'dart:io';

class Fish {
  int timer;
  bool isNew = true;

  Fish(this.timer, {this.isNew = true});

  bool spawnFish() {
    if (timer == 0) {
      timer = 6;
      return true;
    }

    if (timer == 6) {
      isNew = false;
    }

    --timer;
    return false;
  }
}

void main() async {
  final fishes = (await File('input.txt').readAsString())
      .split(',')
      .map((e) => Fish(int.parse(e.trim()), isNew: false))
      .toList();

  for (int i = 0; i < 80; i++) {
    final newFishes = List<Fish>.empty(growable: true);
    fishes.forEach((fish) {
      if (fish.spawnFish()) {
        newFishes.add(Fish(8));
      }
    });
    fishes.addAll(newFishes);
  }

  print(fishes.length);
}
