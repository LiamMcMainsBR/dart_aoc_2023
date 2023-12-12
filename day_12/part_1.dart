import 'dart:io';
import 'package:collection/collection.dart';

void main() {
  final currentDirectory = Directory.current;
  final input =
      File('${currentDirectory.path}/day_12/input.txt').readAsStringSync();

  int total = 0;

  for (final line in input.split('\n')) {
    final pattern = line.split(' ').first;
    final key = line.split(' ').last;
    final keyMap = key.split(',').map(int.parse).toList();

    // Brute force FTW
    final permutations = getAllPermutations(pattern);

    for (final permutation in permutations) {
      final lengthMap = permutation
          .split('.')
          .whereNot((element) => element.isEmpty)
          .map((e) => e.length)
          .toList();

      if (const ListEquality<int>().equals(lengthMap, keyMap)) {
        total++;
      }
    }
  }

  // Part 1
  print(total);
}

List<String> getAllPermutations(String str) => _getPermutations(str, 0);

List<String> _getPermutations(String str, int index) {
  final isWild = str[index] == '?';

  if (isWild) {
    if (index == str.length - 1) {
      return [
        str.replaceRange(index, index + 1, '.'),
        str.replaceRange(index, index + 1, '#')
      ];
    }

    return [
      ..._getPermutations(str.replaceRange(index, index + 1, '.'), index + 1),
      ..._getPermutations(str.replaceRange(index, index + 1, '#'), index + 1),
    ];
  } else {
    if (index == str.length - 1) {
      return [str];
    } else {
      return _getPermutations(str, index + 1);
    }
  }
}
