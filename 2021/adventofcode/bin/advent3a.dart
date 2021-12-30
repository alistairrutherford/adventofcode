/**
 * AdventOfCode 3
 */

import 'dart:io';
import 'dart:convert';

const String INPUT_DATA = "advent3a.txt";
const int INPUT_DIGITS = 12;


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
  int ASCII_1 = "1".codeUnitAt(0);

  List<String> inputs = loadInput(INPUT_DATA);

  int cutOff = (inputs.length / 2).toInt();

  List<int> counts = List.filled(INPUT_DIGITS, 0);

  for (String number in inputs) {
    int len = number.length;
    for (var index = 0; index < len; index++) {
      var c = number.codeUnitAt(index);
      int current = counts[index];
      if (c == ASCII_1) {
        current++;
        counts[index] = current;
      }
    }
  }

  String gammaBinary = "";
  String epsilonBinary = "";
  for (int count in counts) {
    if (count > cutOff) {
      gammaBinary += "1";
      epsilonBinary += "0";
    } else {
      gammaBinary += "0";
      epsilonBinary += "1";
    }
  }

  int gamma = int.parse(gammaBinary, radix: 2);
  int epsilon = int.parse(epsilonBinary, radix: 2);

  print("Gamma: $gamma, Epsilon: $epsilon");
  print("Power consumption = ${gamma * epsilon}");

}