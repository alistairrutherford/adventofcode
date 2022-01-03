/**
 * AdventOfCode 5
 */

import 'dart:collection';
import 'dart:io';
import 'dart:convert';


const String INPUT_FILE = "test_vents.txt";

/*
 Line : y = mx +c
 */
class LineSegment {
  int x1, y1;
  int x2, y2;

  LineSegment(this.x1, this.y1, this.x2, this.y2);

  double gradient() {
    return (y2-y1) / (x2 - x1);
  }

  double intersectsAtX(LineSegment line) {
    int x3 = line.x1;
    int y3 = line.y1;
    int x4 = line.x2;
    int y4 = line.y2;

    int d = (((x1 - x2) * (y3 - y4)) - ((y1 - y2) * (x3 - x4)));

    int n = (((x1 * y2) - (y1 * x2)) * (x3 - x4)) - ((x1 - x2) * ((x3 * x4) - (y3 * x4)));

    double x = n / d;

    return x;
  }

  double intersectsAtY(LineSegment line) {
    int x3 = line.x1;
    int y3 = line.y1;
    int x4 = line.x2;
    int y4 = line.y2;

    int d = (((x1 - x2) * (y3 - y4)) - ((y1 - y2) * (x3 - x4)));

    int n = (((x1 * y2) - (y1 * x2)) * (y3 - y4)) - ((y1 - y2) * ((x3 * x4) - (y3 * x4)));

    double x = n / d;

    return x;
  }
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
  List<LineSegment> segments = loadSegments(INPUT_FILE);

}