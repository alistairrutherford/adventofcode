import 'dart:io';
import 'dart:convert';

/// A simple class to hold our parsed data
class Move {
  final String direction;
  final int distance;

  Move(this.direction, this.distance);

  @override
  String toString() => '$direction -> $distance';
}

void main() async {
  final String filename = 'advent1a.txt';

  Directory current = Directory.current;

  String filePath = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + filename;

  // Read moves
  List<Move> moves = List.empty();

  try {
    moves = await readAndParseFile(filePath);
    print('Successfully parsed ${moves.length} moves:');
  } catch (e) {
    print('Error: $e');
  }

  // Process moves.
  int currentPosition = 50;
  int lastPosition = currentPosition;
  int hitsZero = 0;

  for (var move in moves) {
    print('Direction: ${move.direction}, Distance: ${move.distance}');

    // We need to split the move into smaller parts
    int total = move.distance;
    while (total > 0) {
      int amount = total;
      if (amount > 100) {
        amount = 100;
      }

      print("amount = $amount");

      /**
       * afterL = ((100 - L) + start) % 100
       * afterR = (start + R) % 100
       */

      switch (move.direction) {
        case 'L':
          currentPosition = ((100 - amount + currentPosition) % 100);

          if (currentPosition == 0) {
            hitsZero++;
          } else {
            if (lastPosition !=0) {
              if (currentPosition >= lastPosition) hitsZero++;
            }
          }

          break;
        case 'R':
          currentPosition = ((currentPosition + amount) % 100);

          if (currentPosition == 0) {
            hitsZero++;
          } else {
            if (lastPosition != 0) {
              if (currentPosition <= lastPosition) hitsZero++;
            }
          }
          break;
      }

      print('Currentposition: $currentPosition, Zeroes: $hitsZero');

      lastPosition = currentPosition;
      total = total - 100;
    }

  }

  print("Combination is $hitsZero");

}

Future<List<Move>> readAndParseFile(String path) async {
  final file = File(path);

  if (!await file.exists()) return [];

  return file.openRead()
      .transform(utf8.decoder)       // Decode bytes to UTF-8
      .transform(const LineSplitter()) // Split stream into individual lines
      .where((line) => line.isNotEmpty) // Safety: Skip empty lines
      .map((line) {
    // --- PARSING LOGIC ---
    // 1. Extract the first character for direction
    String dir = line.substring(0, 1);

    // 2. Extract the rest of the string and parse to int
    int dist = int.parse(line.substring(1));

    // 3. Return the object
    return Move(dir, dist);
  })
      .toList(); // Collect all Move objects into a List
}