/**
* AdventOfCode 1
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
 * Count the number of 1 in series
 */
int countOnes(List<String> inputs, int index) {
  int ASCII_1 = "1".codeUnitAt(0);

  List<int> counts = List.filled(INPUT_DIGITS, 0);

  int count = 0;
  for (String number in inputs) {
    var c = number.codeUnitAt(index);
    if (c == ASCII_1) {
      count++;
    }
  }

  return count;
}

/**
 * Filter list on column and values.
 *
 */
List<String> filter(List<String> inputs, int index, var char) {
  int ASCII_1 = "1".codeUnitAt(0);
  List<String> outputs = List<String>.empty(growable: true);

  for (String number in inputs) {
    var c = number.codeUnitAt(index);
    if (c == char) {
      outputs.add(number);
    }
  }

  return outputs;
}

/**
 * Main
 */
main(List<String> arguments) {
  int ASCII_0 = "0".codeUnitAt(0);
  int ASCII_1 = "1".codeUnitAt(0);

  List<String> inputs = loadInput(INPUT_DATA);

  // Copy inputs
  List<String> working = List<String>.from(inputs);

  bool finished = false;
  int index = 0;
  while (!finished) {

    int total = working.length;
    int ones = countOnes(working, index);
    int zeroes = total - ones;

    if (ones >= zeroes) {
      working = filter(working, index, ASCII_1);
    }
    else {
      working = filter(working, index, ASCII_0);
    }

    index++;

    finished = working.length == 1 || index >= INPUT_DIGITS;
  }

  int oxygen = 0;
  if (index <= INPUT_DIGITS) {
    oxygen = int.parse(working[0], radix: 2);
    print("Oxygen : $oxygen");
  }

  working = List<String>.from(inputs);
  finished = false;
  index = 0;
  while (!finished) {

    int total = working.length;
    int ones = countOnes(working, index);
    int zeroes = total - ones;

    if (ones >= zeroes) {
      working = filter(working, index, ASCII_0);
    }
    else {
      working = filter(working, index, ASCII_1);
    }

    index++;

    finished = working.length == 1 || index >= INPUT_DIGITS;
  }

  int co2 = 0;

  if (index <= INPUT_DIGITS) {
    co2 = int.parse(working[0], radix: 2);
    print("CO2 : $co2");
  }

  print("Answer ${oxygen * co2}");
}