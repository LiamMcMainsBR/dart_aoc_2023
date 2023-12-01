import 'dart:io';

void main() {
  final currentDirectory = Directory.current;
  final input = File('${currentDirectory.path}/day_5/input.txt')
      .readAsStringSync();

  print(input);

}