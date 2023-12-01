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

  String replaceNumberStringsWithInts(String input) {
    /// Add the first and last character of the text form of the number back around
    /// the integer so that the replaceAll calls below will work with overlapping
    /// matches, such as 'oneight' or 'eightwo'.
    ///
    /// If any numbers overlapped with multiple letters, this wouldn't work, but
    /// luckily that's not the case.
    return input
        .replaceAll('one', 'o1e')
        .replaceAll('two', 't2o')
        .replaceAll('three', 't3e')
        .replaceAll('four', 'f4r')
        .replaceAll('five', 'f5e')
        .replaceAll('six', 's6x')
        .replaceAll('seven', 's7n')
        .replaceAll('eight', 'e8t')
        .replaceAll('nine', 'n9e');
  }

  int createIntFromFirstAndLastNumber(String input) => int.parse(
        input.split('').first + input.split('').last,
      );

  print(
    input
        .split(LINE_DELIMITER)
        .map(trim)
        .map(replaceNumberStringsWithInts)
        .map(removeNonNumericCharacters)
        .map(createIntFromFirstAndLastNumber)
        .fold<int>(0, sum),
  );
}
