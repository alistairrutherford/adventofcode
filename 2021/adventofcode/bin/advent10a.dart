/**
 * AdventOfCode 10
 */

import 'dart:io';
import 'dart:convert';

const String INPUT_FILE = "advent9.txt";

/**
 * Load input and build data stricture
 *
 */
List<String> loadInput(String fileName) {
  Directory current = Directory.current;
  String path = current.toString().split(' ')[1].replaceAll('\'', '') +
      "/bin/" + fileName;
  var file = File(path);
  List<String> lines = file.readAsLinesSync(encoding: ascii);

  return lines;
}

  /**
   * Main.
   */
  main(List<String> arguments) {
    // Load data.
    List<String> lines = loadInput(INPUT_FILE);

    int total = 0;

    print("total: $total");
  }
