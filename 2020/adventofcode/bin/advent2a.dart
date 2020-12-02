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
  int lowest;
  int highest;
  int character;
  String password;
  bool status = false;

  var parts = definition.split(" ");
  if (parts.length == 3) {
    var range = parts[0];
    var lowerHigher = range.split("-");
    if (lowerHigher.length == 2) {
      lowest = int.parse(lowerHigher[0]);
      highest = int.parse(lowerHigher[1]);

      character = parts[1].codeUnitAt(0);
      password = parts[2];

      int index = 0;
      int count = 0;
      while (index < password.length) {
        int current = password[index].codeUnitAt(0);
        if (current == character)  {
          count++;
        }
        index++;
      }
      // Count should lie between the lowest and highest
      status = count>=lowest && count<=highest;
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