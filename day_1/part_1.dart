import 'dart:io';

void main() {
  final input = File(
    '/Users/liam.mcmains/Documents/Github/dart_aoc_2023/day_1/input.txt',
  ).readAsStringSync();

  const LINE_DELIMITER = '\n';

  int sum(int starting, int current) => starting + current;

  String trim(String input) {
    return input.trim();
  }

  String removeNonNumericCharacters(String input) {
    return input.replaceAll(RegExp(r'[^0-9]'), '');
  }

  int createIntFromFirstAndLastNumber(String input) => int.parse(
        input.split('').first + input.split('').last,
      );

  print(
    input
        .split(LINE_DELIMITER)
        .map(trim)
        .map(removeNonNumericCharacters)
        .map(createIntFromFirstAndLastNumber)
        .fold<int>(0, sum),
  );
}
