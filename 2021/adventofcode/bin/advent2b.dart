/**
* AdventOfCode 1
*/

import 'dart:io';
import 'dart:convert';

const String INPUT_DATA = "advent2a.txt";
const String FORWARD = "forward";
const String BACK = "back";
const String UP = "up";
const String DOWN = "down";


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

/**
 * Main
 */
main(List<String> arguments) {

  List<String> inputs = loadInput(INPUT_DATA);

  int x = 0, z = 0;
  int aim = 0;

  for (String command in inputs) {
    var parts = command.trim().split(" ");
    if (parts.length == 2) {
      String direction = parts[0];
      int amount = int.parse(parts[1]);

      switch (direction) {
        case FORWARD:
          x += amount;
          z += (amount * aim);
          break;
        case BACK:
          x -= amount;
          break;
        case UP:
          aim -= amount;
          break;
        case DOWN:
          aim += amount;
          break;
        default:
          break;
      }
    }
  }
  
  print("Increase: ${x * z}");

}