/**
* AdventOfCode 1
*/

import 'dart:io';
import 'dart:convert';

const String INPUT_DATA = "advent1a.txt";

/**
 * Load input lines.
 */
List<int> loadInput(String fileName) {
  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

  var file = File(path);

  List<String> lines = file.readAsLinesSync(encoding: ascii);

  List<int> listOfInts = <int>[];
  for (String value in lines) {
    listOfInts.add(int.parse(value));
  }

  return listOfInts;
}

main(List<String> arguments) {

  List<int> inputs = loadInput(INPUT_DATA);

  int countGreater = 0;
  int countLessThan = 0;

  int lastValue = -1;
  for (int value in inputs) {
    if (lastValue != -1) {
      if (value > lastValue) {
        countGreater++;
      } else if (value < lastValue){
        countLessThan++;
      }
    }
    lastValue = value;
  }

    print("Greater: $countGreater");
    print("Lesser: $countLessThan");

}