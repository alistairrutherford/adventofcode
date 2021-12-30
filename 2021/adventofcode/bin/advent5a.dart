/**
* AdventOfCode 1
*/

import 'dart:collection';
import 'dart:io';
import 'dart:convert';


const String INPUT_FILE = "test_vents.txt";

class LineSegment {
  int x1, y1;
  int x2, y2;

  LineSegment(this.x1, this.y1, this.x2, this.y2);
}

/**
 * Load input.
 */
List<LineSegment> loadSegments(String fileName) {
  List<LineSegment> segments = List<LineSegment>.empty(growable: true);

  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

  var file = File(path);

  List<String> lines = file.readAsLinesSync(encoding: ascii);

  for (String line in lines) {

  }
  return segments;
}

/**
 * Main
 */
main(List<String> arguments) {
  // Load data.
  List<LineSegment> segmens = loadSegments(INPUT_FILE);

}