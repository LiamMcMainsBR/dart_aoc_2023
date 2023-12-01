import 'dart:io';

void main() {
  final currentDirectory = Directory.current;
  final input = File('${currentDirectory.path}/day_11/input.txt')
      .readAsStringSync();

  print(input);

}