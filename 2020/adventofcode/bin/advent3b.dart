/**
 * AdventOfCode 3b
 *
 */
import 'dart:io';
import 'dart:convert';

const String INPUT_DATA = "advent3input.txt";

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
 * Define our Move class.
 */
class Move {
  int x;
  int y;
  Move(this.x, this.y);
}

main(List<String> arguments) {
  // Get characters for tree and space.
  int TREE = '#'.codeUnitAt(0);

  List<String> rows = loadInput(INPUT_DATA);
  List<Move> MOVES = [Move(1,1), Move(3,1), Move(5,1), Move(7,1), Move(1,2)];
  List<int> totals = List<int>();

  if (rows.length > 0) {
    int squaresX = rows[0].length;
    int squaresY = rows.length;

    for (Move move in MOVES) {
      int treeCount = 0;
      int xIncrement = move.x;
      int yIncrement = move.y;

      int x = 0;
      int y = 0;
      bool finished = false;
      while (!finished) {
        y += yIncrement;
        if (y >= squaresY) {
          finished = true;
        } else {
          x = (x + xIncrement) % squaresX;
          String row = rows[y];
          int charAt = row.codeUnitAt(x);
          if (charAt == TREE) {
            treeCount++;
          }
        }
      }
      totals.add(treeCount);
    }
  }

  final total = totals.reduce((value, element) => value * element);

  print("Total: ${total}");
}