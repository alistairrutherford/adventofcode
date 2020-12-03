/**
 * AdventOfCode 3
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

main(List<String> arguments) {

  // Get characters for tree and space.
  int TREE = '#'.codeUnitAt(0);
  int SPACE = '.'.codeUnitAt(0);

  List<String> rows = loadInput(INPUT_DATA);

  int treeCount = 0;

  if (rows.length > 0) {
    int squaresX = rows[0].length;
    int squaresY = rows.length;

    int xIncrement = 3;
    int yIncrement = 1;

    int x = 0;
    int y = 0;
    int charAt;
    bool finished = false;
    while (!finished) {
      y += yIncrement;
      if (y >= squaresY) {
        finished = true;
      } else {
        x = (x + xIncrement) % squaresX;
        String row = rows[y];
        charAt =  row.codeUnitAt(x);
        if (charAt == TREE) {
          treeCount++;
        }
      }
    }
  }

  print("Count: ${treeCount}");

}