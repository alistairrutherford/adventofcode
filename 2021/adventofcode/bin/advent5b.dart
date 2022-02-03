/**
 * AdventOfCode 5
 */

import 'dart:collection';
import 'dart:io';
import 'dart:convert';


const String INPUT_FILE = "test_vents.txt";
const int LIMITY = 10;

/*
 Line : y = mx +c
 */
class LineSegment {
  int x1, y1;
  int x2, y2;

  LineSegment(this.x1, this.y1, this.x2, this.y2);

  double gradient() {
    return (y2 - y1) / (x2 - x1);
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

  bool doLinesIntersect(LineSegment segment) {
    if (x1 == x2) {
      return !(segment.x1 == segment.x2 && x1 != segment.x1);
    } else if (segment.x1 == segment.x2) {
      return true;
    } else {
      // Both lines are not parallel to the y-axis
      double m1 = gradient();
      double m2 = segment.gradient();
      return m1 != m2;
    }
  }

  bool isHorizontalOrVertical() {
    return isHorizontal() || isVertical();
  }

  bool isHorizontal() {
    return y1 == y2;
  }

  bool isVertical() {
    return x1 == x2;
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

    var parts = line.trim().split(" ");
    var start = parts[0].trim().split(",");
    var end = parts[2].trim().split(",");

    int x1 = int.parse(start[0].trim());
    int y1 = int.parse(start[1].trim());

    int x2 = int.parse(end[0].trim());
    int y2 = int.parse(end[1].trim());

    LineSegment lineSegment = LineSegment(x1, y1, x2, y2);

    segments.add(lineSegment);
  }
  return segments;
}

void coordsAlongX(int xStart, int xEnd, int constY, Map<String, int> coords) {
  for (int x=xStart; x<=xEnd; x++) {
    int count = 1;
    String coordinate = "(" + x.toString() + "," + constY.toString()+ ")";

    var current = coords[coordinate];
    if (current != null) {
      count = (current + 1);
    }
    coords[coordinate] = count;
  }
}

void coordsAlongY(int yStart, int yEnd, int constX, Map<String, int> coords) {
  for (int y=yStart; y<=yEnd; y++) {
    int count = 1;
    String coordinate = "(" + constX.toString() + "," + y.toString() + ")";
    var current = coords[coordinate];
    if (current != null) {
      count = (current + 1);
    }
    coords[coordinate] = count;
  }
}

void coordsAlongPositiveGradient(int xStart, int yStart, int xEnd, int yEnd, Map<String, int> coords) {
  int x = xStart;
  int y = yStart;
  while (x <= xEnd) {
    int count = 1;
    String coordinate = "(" + x.toString() + "," + y.toString() + ")";
    var current = coords[coordinate];
    if (current != null) {
      count = (current + 1);
    }
    coords[coordinate] = count;
    x++; y++;
  }
}

void coordsAlongNegativeGradient(int xStart, int yStart, int xEnd, int yEnd, Map<String, int> coords) {
  int x = xStart;
  int y = yStart;
  while (x <= xEnd) {
    int count = 1;
    String coordinate = "(" + x.toString() + "," + y.toString() + ")";
    var current = coords[coordinate];
    if (current != null) {
      count = (current + 1);
    }
    coords[coordinate] = count;
    x++; y--;
  }
}

/**
 * Main.
 */
main(List<String> arguments) {
  // Load data.
  List<LineSegment> segments = loadSegments(INPUT_FILE);
  Map<String, int> coords = HashMap<String, int>();

  // Build map of position
  for (LineSegment segment in segments) {
    int x1 = segment.x1;
    int y1 = segment.y1;
    int x2 = segment.x2;
    int y2 = segment.y2;

    // Only consider horizontal or vertical line segments
    if (segment.isHorizontal()) {
      if (x1 > x2) {
        coordsAlongX(x2, x1, y1, coords);
      } else {
        coordsAlongX(x1, x2, y1, coords);
      }
    }
    else
      if (segment.isVertical()) {
        if (y1 > y2) {
          coordsAlongY(y2, y1, x1, coords);
        } else {
          coordsAlongY(y1, y2, x1, coords);
        }
      } else {
        // Diagonal
        double gradient = segment.gradient();
        if (gradient > 0) {
          // Positive
          if (x1 > x2) {
            coordsAlongPositiveGradient(x2, y2, x1, y1, coords);
          } else {
            coordsAlongPositiveGradient(x1, y1, x2, y2, coords);
          }
        } else {
          // Negative
          if (x1 > x2) {
            coordsAlongNegativeGradient(x2, y2, x1, y1, coords);
          } else {
            coordsAlongNegativeGradient(x1, y1, x2, y2, coords);
          }
        }

      }
  }

  int total = 0;
  for (int count in coords.values) {
    if (count > 1) {
      total++;
    }
  }

  print("Count: $total");
}
