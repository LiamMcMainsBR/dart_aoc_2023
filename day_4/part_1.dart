import 'dart:io';
import 'dart:math';

void main() {
  final currentDirectory = Directory.current;
  final input =
      File('${currentDirectory.path}/day_4/input.txt').readAsStringSync();

  final numbers = input.split('\n').map(
        (e) => e
            .split(':')
            .last
            .split('|')
            .map((e) => e.split(' ').where((element) => element.isNotEmpty)),
      );

  /// Write a function to calculate the number of shared elements between two lists
  int numberOfSharedElements(Iterable<String> list1, Iterable<String> list2) {
    var result = 0;

    for (final element in list1) {
      if (list2.contains(element)) {
        result++;
      }
    }

    return result;
  }

  print(
    numbers
        .map((e) => numberOfSharedElements(e.first, e.last))
        .map((e) => pow(2, e - 1))
        .where((element) => element > 0.5)
        .fold<num>(0, (previousValue, element) => previousValue + element),
  );
}
