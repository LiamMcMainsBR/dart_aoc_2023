import 'dart:io';

void main() {
  final currentDirectory = Directory.current;
  final input =
      File('${currentDirectory.path}/day_11/input.txt').readAsStringSync();

  final expandedInput = expandSpaceInput(input);

  final List<List<int>> locations = calculateGalaxyLocations(expandedInput);

  final List<List<List<int>>> pairs = calculateGalaxyPairs(locations);

  print(calculateDistanceSum(pairs));
}

int calculateDistanceSum(List<List<List<int>>> pairs) {
  final sum = pairs
      .map(calculateDistanceBetweenPointPairs)
      .fold<int>(0, (previousValue, element) => previousValue + element);
  return sum;
}

List<List<List<int>>> calculateGalaxyPairs(List<List<int>> locations) {
  final List<List<List<int>>> pairs = [];
  for (var i = 0; i < locations.length; i++) {
    for (var j = i + 1; j < locations.length; j++) {
      pairs.add([locations[i], locations[j]]);
    }
  }
  return pairs;
}

List<List<int>> calculateGalaxyLocations(List<String> expandedInput) {
  final List<List<int>> locations = [];

  var i = 0;
  for (final line in expandedInput) {
    var j = 0;
    for (final character in line.split('')) {
      if (character == '#') {
        locations.add([i, j]);
      }
      j++;
    }
    i++;
  }
  return locations;
}

int calculateDistanceBetweenPointPairs(List<List<int>> e) {
  final firstPoint = e.elementAt(0);
  final secondPoint = e.elementAt(1);

  final xDiff = firstPoint.first - secondPoint.first;
  final yDiff = firstPoint.last - secondPoint.last;

  final sum = xDiff.abs() + yDiff.abs();

  return sum;
}

List<String> expandSpaceInput(String splitInput) {
  var inputCopy = splitInput.split('\n');

  expandHorizontalSpace(inputCopy);

  inputCopy = transposeList(inputCopy);

  expandHorizontalSpace(inputCopy);

  return transposeList(inputCopy);
}

void expandHorizontalSpace(List<String> modifiedInput) {
  var index = 0;
  for (final line in modifiedInput.toList()) {
    index++;
    if (line.split('').every((element) => element == '.')) {
      modifiedInput.insert(index, line);
      index++;
    }
  }
}

List<String> transposeList(List<String> input) {
  return transposeArray(input.map((e) => e.split('')).toList())
      .map((e) => e.join())
      .toList();
}

List<List<String>> transposeArray(List<List<String>> input) {
  final List<List<String>> output = [];

  if (input.any((element) => element.length != input[0].length)) {
    throw const FormatException('Not a rectangle Matrix');
  }

  for (int i = 0; i < input[0].length; i++) {
    output.add(List<String>.generate(input.length, (idx) => ''));
  }

  for (int i = 0; i < input.length; i++) {
    final List<String> column = input[i];
    for (int j = 0; j < input[0].length; j++) {
      final String rowItem = column[j];
      output.elementAt(j).removeAt(i);
      output.elementAt(j).insert(i, rowItem);
    }
  }

  return output;
}
