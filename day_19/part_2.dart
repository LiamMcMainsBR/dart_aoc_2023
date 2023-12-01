import 'dart:io';

void main() {
  final currentDirectory = Directory.current;
  final input = File('${currentDirectory.path}/day_19/input.txt')
      .readAsStringSync();

  print(input);

}