import 'dart:io';

void main() {
  final currentDirectory = Directory.current;
  final input = File('${currentDirectory.path}/day_15/input.txt')
      .readAsStringSync();

  print(input);

}