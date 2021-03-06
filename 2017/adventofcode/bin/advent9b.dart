/**
 * How many non-canceled characters are within the garbage in your puzzle input?
 *
 */

import 'dart:io';
import 'dart:convert';

const String GROUP_START = "{";
const String GROUP_END = "}";
const String GARBAGE_START ="<";
const String GARBAGE_END = ">";
const String IGNORE_NEXT = "!";

const String FILE_NAME = "advent9input.txt";

class StreanProcessor {

  /**
   * Load instructions.
   *
   */
  List<String> load(String fileName) {

    Directory current = Directory.current;

    String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

    var file = new File(path);

    List<String> lines = file.readAsLinesSync(encoding: ASCII);

    return lines;
  }

  /**
   * Process data.
   *
   */
  List<int> process(List<String> lines) {
    List<int> results = new List();

    int depth = 0;
    bool garbage = false;
    bool ignoreNext = false;

    for (String line in lines) {

      int totalGarbage = 0;

      for (int i=0; i< line.length; i++) {
        String char = line[i].trim();

        if (!ignoreNext) {

          switch (char) {
            case GROUP_START:
              if (garbage) {
                totalGarbage++;
              }
              break;
            case GROUP_END:
              if (garbage) {
                totalGarbage++;
              }
              break;
            case GARBAGE_START:
              if (!garbage) {
                garbage = true;
              } else {
                totalGarbage++;
              }
              break;
            case GARBAGE_END:
              if (garbage) {
                garbage = false;
              } else {
              totalGarbage++;
              }
              break;
            case IGNORE_NEXT:
              if (garbage) {
                ignoreNext = true;
              }
              break;
            default:
              if (garbage) {
                totalGarbage++;
              }
              break;
          }

        } else {
          ignoreNext = false;
        }

      }

      results.add(totalGarbage);
    }

    return results;
  }

}

/**
 * Main.
 *
 */
main(List<String> arguments) {

  StreanProcessor streanProcessor = new StreanProcessor();

  List<String> lines = streanProcessor.load(FILE_NAME);

  List<int> totals = streanProcessor.process(lines);

  for (int total in totals) {
    print("Answer is: $total");
  }

}