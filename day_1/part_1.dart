import 'dart:io';

void main() {
  final currentDirectory = Directory.current;
  final input =
      File('${currentDirectory.path}/day_1/input.txt').readAsStringSync();

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
