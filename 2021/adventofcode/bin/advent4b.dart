/**
* AdventOfCode 1
*/

import 'dart:io';
import 'dart:convert';

const String INPUT_MOVES = "advent4_draws.txt";
const String INPUT_BOARDS = "advent4_boards.txt";
const int BOARD_SIZE = 5;


/**
 * Load input lines.
 */
List<int> loadDraws(String fileName) {
  List<int> draws = List<int>.empty(growable: true);

  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

  var file = File(path);

  List<String> lines = file.readAsLinesSync(encoding: ascii);

  String drawString = lines[0];

  var values = drawString.split(",");
  for (var value in values) {
    int intValue = int.parse(value);
    draws.add(intValue);
  }
  return draws;
}

List<Board> loadBoards(String fileName) {
  List<Board> boards = List<Board>.empty(growable: true);

  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

  var file = File(path);

  List<String> lines = file.readAsLinesSync(encoding: ascii);

  Board board = Board();
  boards.add(board);
  for (String line in lines) {
    if (line.isNotEmpty) {
      var values = line.split(" ");
      List<int> rowValues = List<int>.empty(growable: true);
      for (var value in values) {
        if (value.isNotEmpty) {
          int intValue = int.parse(value);
          rowValues.add(intValue);
        }
      }
      board.addRow(rowValues);
    } else {
      board = Board();
      boards.add(board);
    }
  }

  return boards;
}

class Marker {
  int value;
  bool marked;
  Marker(this.value, this.marked);
}

class Board {
  List<List<Marker>> rows = List.generate(0, (i) => []);

  void addRow(List<int> row) {
    List<Marker> markers = List<Marker>.empty(growable: true);

    for (int value in row) {
      markers.add(Marker(value, false));
    }

    rows.add(markers);
  }

  bool houseRows() {
    // Check the rows
    bool finished = false;
    bool found = false;
    int rowIndex = 0;
    while (!finished && !found) {
      List<Marker> row = rows[rowIndex];
      found = true;
      for (Marker marker in row) {
        found = found && marker.marked;
      }
      rowIndex++;
      finished = rowIndex >= BOARD_SIZE;
    }

    return found;
  }

  bool houseColumns() {
    // Check the columns
    bool finished = false;
    bool found = false;
    int columnIndex = 0;
    while (!finished && !found) {
      found = true;
      for (List<Marker> rowList in rows) {
        Marker marker = rowList[columnIndex];
        found = found && marker.marked;
      }
      columnIndex++;
      finished = columnIndex >= BOARD_SIZE;
    }
    return found;
  }

  bool house() {
    bool house = houseRows();
    if (!house) {
      house = houseColumns();
    }
    return house;
  }

  void markBoard(int value) {
    // For each row
    for (List<Marker> row in rows) {
      for (Marker marker in row) {
        if (marker.value == value) {
          marker.marked = true;
        }
      }
    }
  }

  int sumUnmarked() {
    int sum = 0;
    // For each row
    for (List<Marker> row in rows) {
      for (Marker marker in row) {
        if (!marker.marked) {
          sum += marker.value;
        }
      }
    }
    return sum;
  }

}

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

List<int> buildDraws(List<String> input) {
  List<int> draws = List<int>.empty(growable: true);

  String drawString = input[0];

  var values = drawString.split(" ");
  for (var value in values) {
    int intValue = int.parse(value);
    draws.add(intValue);
  }
  return draws;
}

/**
 * Unfinished.
 */
List<Board> buildBoards(List<String> input) {
  List<Board> boards = List<Board>.empty(growable: true);

  // Start at position 3.
  int index = 2;
  int size = BOARD_SIZE;
  Board board = Board();
  for (String row in input) {
    if (row.isEmpty) {
      Board board = Board();
    } else {
      board = Board();
      boards.add(board);
    }
  }

  return boards;
}

// Look for house on boards until we find one or none.
bool processBoards(List<Board> boards) {
  bool found = false;
  bool finished = false;
  int total = boards.length;
  int index = 0;
  while (!finished && !found) {
    Board board = boards[index];
    found = board.house();
    index++;
    finished = index >= BOARD_SIZE;
  }

  return found;
}

List<int> processDraws(List<String> input) {
  List<int> draws = List<int>.empty(growable: true);

  String drawString = input[0];
  var items = drawString.split(" ");
  for (var item in items) {
    int value = int.parse(item);
    draws.add(value);
  }
  return draws;
}


/**
 * Main
 */
main(List<String> arguments) {
  // Load data.
  List<int> draws = loadDraws(INPUT_MOVES);
  List<Board> boards = loadBoards(INPUT_BOARDS);
  List<Board> winners = List.empty(growable: true);

  bool finished = false;
  bool found = false;
  int drawIndex = 0;
  int boardIndex = 0;
  int draw = -1;
  while (!finished && !found) {
    draw = draws[drawIndex];

    // Pass move to each board until all boards or house
    boardIndex = 0;
    bool boardsFinished = false;
    while (!boardsFinished && !found) {
      Board board = boards[boardIndex];
      board.markBoard(draw);
      found = board.house();
      if (!found) boardIndex++;
      boardsFinished = boardIndex >= boards.length;
    }

    if (! found) drawIndex++;
    
    finished = drawIndex >= draws.length;
  }

  if (found) {
    print("Bingo on board: ${boardIndex + 1}");
    Board bingoBoard = boards[boardIndex];
    int sum = bingoBoard.sumUnmarked();
    print("Sum unmarked: $sum");
    print("Total: ${sum * draw}");
  }

}