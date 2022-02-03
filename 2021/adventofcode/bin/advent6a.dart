/**
 * AdventOfCode 5
 */

import 'dart:collection';
import 'dart:io';
import 'dart:convert';

const String INPUT_FILE = "advent6.txt";

/**
 * Load input.
 */
List<int> loadAges(String fileName) {
  List<int> ages = List<int>.empty(growable: true);

  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

  var file = File(path);

  List<String> lines = file.readAsLinesSync(encoding: ascii);

  for (String line in lines) {
    var parts = line.trim().split(",");
    for (var part in parts) {
      int age = int.parse(part.trim());
      ages.add(age);
    }
  }

  return ages;
}

/**
 * Main.
 */
main(List<String> arguments) {
  // Load data.
  List<int> ages = loadAges(INPUT_FILE);
  int days = 18;

  while (days > 0) {
    int total = 0;
    int length = ages.length;
    int index = 0;
    while (index < length) {
      int value = ages[index] - 1;
      if (value < 0) {
        value = 6; // Reset fish
        ages[index] = 6; // put back
        ages.add(8); // add new fish
      } else {
        ages[index] = value;
      }
      index++;
    }
    //print("Day: ${days}, ${ages}");
    days--;
  }

  print("Total: ${ages.length}");
}
