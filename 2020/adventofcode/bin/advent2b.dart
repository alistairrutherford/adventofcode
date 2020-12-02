/**
 * AdventOfCode 2
 *
 */
import 'dart:io';
import 'dart:convert';

const String INPUT_DATA = "advent2input.txt";

/**
 * Validate password definition: 4-8 r: fqnqjbsssqrrwrrrrr
 */
bool validate(String definition) {
  int first;
  int last;
  int character;
  String password;
  bool status = false;

  var parts = definition.split(" ");
  if (parts.length == 3) {
    var range = parts[0];
    var lowerHigher = range.split("-");
    if (lowerHigher.length == 2) {
      character = parts[1].codeUnitAt(0);
      password = parts[2];

      // Extract characters
      first = int.parse(lowerHigher[0]);
      last = int.parse(lowerHigher[1]);
      // Check if valid
      if (first<=password.length && last<=password.length) {
        int firstChar = password[first-1].codeUnitAt(0);
        int secondChar = password[last-1].codeUnitAt(0);

        status = ((firstChar == character)||(secondChar == character)) && (firstChar != secondChar);
      }
    }
  }
  return status;
}

/**
 * Load input lines.
 */
List<String> loadInput(String fileName) {
  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

  var file = File(path);

  List<String> lines = file.readAsLinesSync(encoding: ascii);

  return lines;
}

main(List<String> arguments) {

  List<String> inputs = loadInput(INPUT_DATA);

  int validCount = 0;
  for (String value in inputs) {
    if (validate(value)) validCount++;
  }

  print("Count: ${validCount}");

}