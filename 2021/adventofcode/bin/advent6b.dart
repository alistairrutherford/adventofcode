/**
 * AdventOfCode 6
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
  List<int> counts = List.filled(9, 0); // Fill list of counts

  // Initialise array of counts
  for (int age in ages) {
    counts[age]++;
  }

  int days = 256;

  print("Initial: ${days}, ${counts}");

  while (days > 0) {

    int toZero = counts [0];
    // Shuffle down
    for (int index = 0; index < counts.length-1; index++) {
      counts[index] = counts[index+1];
    }
    counts[6] = counts[6] + toZero;
    counts[8] = toZero;

    //print("Day: ${days}, ${counts}");

    days--;
  }

  int total = 0;
  for (int value in counts) {
    total += value;
  }

  print("Total: ${total}");
}
