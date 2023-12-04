import 'dart:io';
import 'dart:math';

void main() {
  final currentDirectory = Directory.current;
  final input =
      File('${currentDirectory.path}/day_2/input.txt').readAsStringSync();

  const redHandMax = 12;
  const greenHandMax = 13;
  const blueHandMax = 14;

  final failingGames = <String, bool>{};
  final powers = <int>[];

  for (final line in input.split('\n')) {
    final gameId = line.split(':')[0].split(' ')[1];

    failingGames[gameId] = false;

    var redLineTotal = 0;
    var blueLineTotal = 0;
    var greenLineTotal = 0;

    for (var hand in line.split(';')) {
      var redHandTotal = 0;
      var blueHandTotal = 0;
      var greenHandTotal = 0;

      if (hand.contains('Game ')) {
        hand = hand.split(':')[1];
      }

      for (final pull in hand.split(',')) {
        if (pull.contains('red')) {
          redHandTotal += int.parse(pull.split(' ')[1]);
        } else if (pull.contains('blue')) {
          blueHandTotal += int.parse(pull.split(' ')[1]);
        } else if (pull.contains('green')) {
          greenHandTotal += int.parse(pull.split(' ')[1]);
        }

        if (redHandTotal > redHandMax ||
            blueHandTotal > blueHandMax ||
            greenHandTotal > greenHandMax) {
          failingGames[gameId] = true;
        }
      }

      redLineTotal = max(redLineTotal, redHandTotal);
      blueLineTotal = max(blueLineTotal, blueHandTotal);
      greenLineTotal = max(greenLineTotal, greenHandTotal);
    }

    powers.add(redLineTotal * greenLineTotal * blueLineTotal);
  }

  // Part 1
  print(
    failingGames.entries.where((element) => !element.value).fold<int>(
          0,
          (previousValue, element) => previousValue + int.parse(element.key),
        ),
  );

  // Part 2
  print(
    powers.fold<int>(0, (previousValue, element) => previousValue + element),
  );
}
