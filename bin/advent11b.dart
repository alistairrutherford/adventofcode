/**
 * n: 0, 1, -1
 * s: 0, -1, 1
 * nw: -1, 1, 0
 * se: 1, -1, 0
 * ne: 1, 0, -1
 * sw: -1, 0, 1
 *
 */
import 'dart:io';
import 'dart:convert';

const String INPUT_DATA = "advent11input.txt";

class Move {
  int x, y, z;

  Move(this.x, this.y, this.z);
}

class PathFinder {

  Move current;

  PathFinder(int x, int y, int z) {
    current =  new Move(x, y, z);;
  }

  /**
   * Map of hexagonal moves.
   * n: 0, 1, -1
   * s: 0, -1, 1
   * nw: -1, 1, 0
   * se: 1, -1, 0
   * ne: 1, 0, -1
   * sw: -1, 0, 1
   */
  Map<String, Move> MOVES =  {
    "n" : new Move(0, 1, -1),
    "s" : new Move(0, -1, 1),
    "nw": new Move(-1, 1, 0),
    "se": new Move(1, -1, 0),
    "ne": new Move(1, 0, -1),
    "sw": new Move(-1, 0, 1),
  };

  /**
   * Calculate distance.
   *
   */
  int currentDistanceFrom(Move a) {
    return ((a.x - current.x).abs() + (a.y - current.y).abs() + (a.z - current.z).abs()) ~/2;
  }

  /**
   * Load steps.
   *
   */
  List<String> load(String fileName) {

    Directory current = Directory.current;

    String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

    var file = new File(path);

    List<String> lines = file.readAsLinesSync(encoding: ASCII);

    List<String> steps = new List();

    for (String line in lines) {
      List<String> parts = line.split(",");
      steps.addAll(parts);
    }

    return steps;
  }

  /**
   * Move position,
   */
  void move(String moveTo) {
    Move move = MOVES[moveTo];
    if (move != null) {
      current.x = current.x + move.x;
      current.y = current.y + move.y;
      current.z = current.z + move.z;
    } else {
      print("Error move not found");
    }
  }

}

main(List<String> arguments) {

  PathFinder pathFinder = new PathFinder(0, 0, 0);

  List <String> moves = pathFinder.load(INPUT_DATA);

  Move initial = new Move(0, 0, 0);
  int max = 0;

  for (String move in moves) {
    pathFinder.move(move.trim());

    int distance = pathFinder.currentDistanceFrom(initial);

    if (distance > max) {
      max = distance;
    }
  }

  print("max distance: $max");

}