import 'dart:io';

void main() {
  final currentDirectory = Directory.current;
  final input =
      File('${currentDirectory.path}/day_5/input.txt').readAsStringSync();

  final Map<String, Map<String, Map<String, int>>> maps = {};

  final lines = input.split('\n');

  final seeds = lines.first
      .split(':')
      .last
      .split(' ')
      .where((element) => element.isNotEmpty);

  lines
    ..removeAt(0)
    ..removeAt(0);

  String fromMapKey = '';
  String toMapKey = '';

  final maxDigit = getMaxDigitValueFromString(input);

  print('Max digit: $maxDigit');

  for (final line in lines.where((element) => element.isNotEmpty)) {
    print('Line processed.....');
    if (!isDigit(line[0])) {
      fromMapKey = line.split('-')[0];
      toMapKey = line.split('-')[2].split(' ').first;

      maps[fromMapKey] = {};
      maps[fromMapKey]![toMapKey] = {};
    } else {
      final sourceKey = int.parse(line.split(' ')[1]);
      final destinationKey = int.parse(line.split(' ')[0]);
      final distance = int.parse(line.split(' ')[2]);

      print('Distance: $distance');

      for (var i = 0; i < distance; i++) {
        maps[fromMapKey]![toMapKey]![(sourceKey + i).toString()] =
            destinationKey + i;
      }
    }
  }

  final locations = <int>[];

  for (final seed in seeds) {
    final keys = maps.keys;
    int i = 0;
    var fromKey = keys.elementAt(i);
    var toKey = keys.elementAt(i + 1);

    int value = int.parse(seed);

    var hasThrown = false;

    while (!hasThrown) {
      try {
        value = maps[fromKey]![toKey]![value.toString()]!;
      } catch (_) {}

      try {
        i++;
        fromKey = keys.elementAt(i);
        toKey = keys.elementAt(i + 1);
      } catch (e) {
        try {
          value = maps[toKey]!['location']![value.toString()]!;
        } catch (_) {}
        hasThrown = true;
        locations.add(value);
      }
    }
  }

  print(
    locations.reduce((value, element) => value < element ? value : element),
  );
}

bool isDigit(String string) => int.tryParse(string) != null;

int getMaxDigitValueFromString(String str) {
  final digits = str.split(' ').where(isDigit);

  return digits
      .map(int.parse)
      .reduce((value, element) => value > element ? value : element);
}
