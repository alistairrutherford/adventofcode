import 'dart:io';
import 'dart:convert';
import 'dart:async';

const String GROUP_START = "{";
const String GROUP_END = "}";
const String GARBAGE_START ="<";
const String GARBAGE_END = ">";
const String NULL_CHAR = "!";

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
  void process(List<String> lines) {
    int total = 0;

    int group;
    bool garbage;
    bool ignoreNext;

    for (String line in lines) {
      for (int i=0; i< line.length; i++) {
        String char = line[i].trim();

        switch (char) {
          case GROUP_START:
            if (!garbage) {
              if (ignoreNext) {
                ignoreNext = false;
              } else {
                group++;

                // Add to total
                total +=group;
              }
            }
            break;
          case GROUP_END:
            if (!garbage) {
              if (!ignoreNext) {
                group--;
              } else {
                ignoreNext = false;
              }
            }
            break;
          case GARBAGE_START:
            if (!garbage) {
              if (!ignoreNext) {
                garbage = true;
              } else {
                ignoreNext = false;
              }
            }
            break;
          case GARBAGE_END:
            if (garbage) {
              if (!ignoreNext) {
                garbage = true;
              } else {
                ignoreNext = false;
              }
            }
            break;
        }

      }
    }
  }

}

/**
 * Main.
 *
 */
main(List<String> arguments) {

  StreanProcessor streanProcessor = new StreanProcessor();

  List<String> lines = streanProcessor.load(FILE_NAME);

  streanProcessor.process(lines);

}