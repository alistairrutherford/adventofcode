/**
 * AdventOfCode 7
 */

import 'dart:collection';
import 'dart:io';
import 'dart:convert';

const String INPUT_FILE = "advent7.txt";
const int intMaxValue = 9223372036854775807;

/**
 * Load input.
 */
List<int> loadPositions(String fileName) {
  List<int> positions = List<int>.empty(growable: true);

  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

  var file = File(path);

  List<String> lines = file.readAsLinesSync(encoding: ascii);

  for (String line in lines) {
    var parts = line.trim().split(",");
    for (var part in parts) {
      int position = int.parse(part.trim());
      positions.add(position);
    }
  }

  return positions;
}

/**
 * Main.
 */
main(List<String> arguments) {
  // Load data.
  List<int> positions = loadPositions(INPUT_FILE);

  // Sort
  positions.sort();

  if (positions.length >=2) {
    int min = positions[0];
    int max = positions[positions.length-1];

    int minCost = intMaxValue;

    for (int value=min; value<=max; value++) {

      // Find min cost
      int totalCost = 0;
      for (int position in positions) {
        int move = (position - value).abs();
        //  S= n/2[2a + (n − 1) × d]
        // a = 1, d = 1 and n = move
        int total = ((move/2) * ((2*1) + (move -1) * 1)).floor();;
        totalCost += total;
      }

      if (totalCost < minCost) {
        minCost = totalCost;
      }
    }

    print("Min cost: $minCost");
  }

  int cost = 0;
  print("Total: ${cost}");
}
