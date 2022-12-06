/**
 * AdventOfCode 10
 */

import 'dart:collection';
import 'dart:io';
import 'dart:convert';

const String INPUT_FILE = "advent10.txt";

final SCORE_MAP = const {')': 3, ']': 57, '}': 1197, '>': 25137};

/**
 * Load input.
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
  int score = 0;

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
      if (scoreBracket1 < 0) {
        score += SCORE_MAP[')']!;
      }
      break;
    case '[':
      scoreBracket2++;
      break;
    case ']':
      scoreBracket2--;
      if (scoreBracket2 < 0) {
        score += SCORE_MAP[']']!;
      }
      break;
    case '{':
      scoreBracket3++;
      break;
    case '}':
      scoreBracket3--;
      if (scoreBracket3 < 0) {
        score += SCORE_MAP['}']!;
      }
      break;
    case '<':
      scoreBracket4++;
      break;
    case '>':
      scoreBracket4--;
      if (scoreBracket4 < 0) {
        score += SCORE_MAP['>']!;
      }
      break;
  }
  map['('] = scoreBracket1;
  map['['] = scoreBracket2;
  map['{'] = scoreBracket3;
  map['<'] = scoreBracket4;

  return score;
}

void resetcountMap(Map<String, int> map) {
  map['('] = 0;
  map['['] = 0;
  map['{'] = 0;
  map['<'] = 0;
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

    for (String line in lines) {
      // Reset counts
      resetcountMap(counts);

      int index = 0;
      bool isCorrupt = false;
      while (index < line.length && !isCorrupt) {
        String char = line[index++];
        int score = updateCountMap(char, counts);
        isCorrupt = score > 0;
        total += score;
      }
    }

    print("total: $total");
  }
