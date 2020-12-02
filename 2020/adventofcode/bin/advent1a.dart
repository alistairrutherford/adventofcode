/**
* AdventOfCode 1
*/

import 'dart:io';
import 'dart:convert';

const String INPUT_DATA = "advent1a.txt";
const int TARGET_VALUE = 2020;

/**
 * Load input lines.
 */
List<int> loadInput(String fileName) {
  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

  var file = File(path);

  List<String> lines = file.readAsLinesSync(encoding: ascii);

  List<int> listOfInts = List<int>();
  for (String value in lines) {
    listOfInts.add(int.parse(value));
  }

  // Lowest to highest
  listOfInts.sort();

  return listOfInts;
}

main(List<String> arguments) {

  List<int> inputs = loadInput(INPUT_DATA);

  bool found = false;
  int length = inputs.length;

  int outerValue = 0;
  int innerValue = 0;

  int outer = 0;
  while ((outer < length) && !found) {
    outerValue = inputs[outer];
    int inner = outer + 1;
    while (inner < length && !found) {
      innerValue = inputs[inner];

      found = (innerValue + outerValue == TARGET_VALUE);

      if (!found) inner++;
    }

    if (!found) outer++;
  }

  if (found) {
    print("Values: ${innerValue}, ${outerValue}");

    print("Answer: ${innerValue * outerValue}");
  }
}