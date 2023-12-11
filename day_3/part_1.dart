import 'dart:io';

bool isSymbol(String str) {
  assert(str.length == 1);

  return str != '.' && int.tryParse(str) == null;
}

bool isNumber(String str) {
  assert(str.length == 1);

  return int.tryParse(str) != null;
}

Map<int, Map<int, bool>> buildAdjacencyMap(String str) {
  final lines = str.split('\n');

  final result = <int, Map<int, bool>>{};

  var i = 0;
  for (final line in lines) {
    for (var j = 0; j < line.length; j++) {
      result[i] ??= {};
      result[i]![j] = false;

      result[i]?[j] = tryPosition(i - 1, j - 1, lines, isSymbol) ||
          tryPosition(i - 1, j, lines, isSymbol) ||
          tryPosition(i - 1, j + 1, lines, isSymbol) ||
          tryPosition(i, j - 1, lines, isSymbol) ||
          tryPosition(i, j, lines, isSymbol) ||
          tryPosition(i, j + 1, lines, isSymbol) ||
          tryPosition(i + 1, j - 1, lines, isSymbol) ||
          tryPosition(i + 1, j, lines, isSymbol) ||
          tryPosition(i + 1, j + 1, lines, isSymbol);
    }

    i++;
  }

  return result;
}

bool tryPosition(
  int i,
  int j,
  List<String> lines,
  bool Function(String str) func,
) {
  try {
    return func(lines[i][j]);
  } catch (e) {
    return false;
  }
}

Map<int, Map<int, bool>> buildGearMap(String str) {
  final lines = str.split('\n');

  final result = <int, Map<int, bool>>{};

  var i = 0;
  for (final line in lines) {
    for (var j = 0; j < line.length; j++) {
      final symbol = line[j];

      if (symbol == '*') {
        result[i] ??= {};
        result[i]![j] = false;

        result[i]?[j] = [
              tryPosition(i - 1, j - 1, lines, isNumber),
              tryPosition(i - 1, j, lines, isNumber),
              tryPosition(i - 1, j + 1, lines, isNumber),
              tryPosition(i, j - 1, lines, isNumber),
              tryPosition(i, j, lines, isNumber),
              tryPosition(i, j + 1, lines, isNumber),
              tryPosition(i + 1, j - 1, lines, isNumber),
              tryPosition(i + 1, j, lines, isNumber),
              tryPosition(i + 1, j + 1, lines, isNumber)
            ]
                .map((e) => e ? 1 : 0)
                .fold(0, (previousValue, element) => previousValue + element) >
            1;
      } else {
        result[i] ??= {};
        result[i]![j] = false;
      }
    }

    i++;
  }

  return result;
}

void main() {
  final currentDirectory = Directory.current;
  final input =
      File('${currentDirectory.path}/day_3/input.txt').readAsStringSync();

  final adjacencyMap = buildAdjacencyMap(input);
  print(
    buildGearMap(input)
        .entries
        .map((e) => e.value.values.map((e) => e ? 1 : 0).join())
        .join('\n'),
  );

  var total = 0;

  var i = 0;
  for (final line in input.split('\n')) {
    var numberString = '';
    var isNumberStringAdjacentToSymbol = false;

    void reset() {
      if (numberString.isNotEmpty) {
        print('Number string: $numberString is adjacent to symbol: '
            '$isNumberStringAdjacentToSymbol');

        if (isNumberStringAdjacentToSymbol) total += int.parse(numberString);
      }

      numberString = '';
      isNumberStringAdjacentToSymbol = false;
    }

    for (var j = 0; j < line.length; j++) {
      final symbol = line[j];
      if (isDigit(symbol)) {
        numberString += symbol;
        if (adjacencyMap[i]?[j] ?? false) {
          isNumberStringAdjacentToSymbol = true;
        }
      } else {
        reset();
      }

      if (j == line.length - 1 && isNumberStringAdjacentToSymbol) {
        reset();
      }
    }

    i++;
  }

  print(total);
}

// Create an isDigit function
bool isDigit(String str) {
  assert(str.length == 1);

  return int.tryParse(str) != null;
}
