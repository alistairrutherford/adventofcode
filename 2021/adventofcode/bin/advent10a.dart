/**
 * AdventOfCode 10
 */

import 'dart:collection';
import 'dart:io';
import 'dart:convert';

const String INPUT_FILE = "advent10.txt";

final SCORE_MAP = const {')': 3, ']': 57, '}': 1197, '>': 25137};

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

///
/// Track opening and closing brackets
///
int updateCountMap(String char, Map<String, int> map) {
  int scoreBracket1 = map['(']!;
  int scoreBracket2 = map['[']!;
  int scoreBracket3 = map['{']!;
  int scoreBracket4 = map['<']!;

  switch (char) {
    case '(':
      scoreBracket1++;
      break;
    case ')':
      scoreBracket1--;
      break;
    case '[':
      scoreBracket2++;
      break;
    case ']':
      scoreBracket2--;
      break;
    case '{':
      scoreBracket3++;
      break;
    case '}':
      scoreBracket3--;
      break;
    case '<':
      scoreBracket4++;
      break;
    case '>':
      scoreBracket4--;
      break;
  }
  map['('] = scoreBracket1;
  map['['] = scoreBracket2;
  map['{'] = scoreBracket3;
  map['<'] = scoreBracket4;

  // Return total count
  int total = 0;
  for (int count in map.values) {
    total += count;
  }
  return total;
}


  /**
   * Main.
   */
  main(List<String> arguments) {
    // Load data.
    List<String> lines = loadInput(INPUT_FILE);

    int total = 0;


    // Initialise map
    Map<String, int> counts =  HashMap<String, int>();
    counts['('] = 0;
    counts['['] = 0;
    counts['{'] = 0;
    counts['<'] = 0;

    // Rule: If the total map count is > number of remaining charavters in the line then it's incomplete
    List<int> scores = List<int>.empty(growable: true);
    for (String line in lines) {
      int index = 0;
      bool isCorrupt = false;
      while (index < line.length && !isCorrupt) {
        String char = line[index++];
        int totalCount = updateCountMap(char, counts);
        if (totalCount > (line.length - index)) {
          isCorrupt = true;
        }
      }
    }
    print("total: $total");
  }
