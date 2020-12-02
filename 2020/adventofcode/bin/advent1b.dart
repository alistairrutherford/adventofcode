/**
 * Given the details of the firewall you've recorded, if you leave immediately,
 * what is the severity of your whole trip?
 *
 */
import 'dart:io';
import 'dart:convert';

const String INPUT_DATA = "advent1a.txt";
const int TARGET_VALUE = 2020;

/**
 * Load input lines.
 */
List<int> loadInput(String fileName) {
  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

  var file = File(path);

  List<String> lines = file.readAsLinesSync(encoding: ascii);

  List<int> listOfInts = List<int>();
  for (String value in lines) {
    listOfInts.add(int.parse(value));
  }

  // Lowest to highest
  listOfInts.sort();

  return listOfInts;
}

main(List<String> arguments) {

  List<int> inputs = loadInput(INPUT_DATA);

  bool found = false;
  int length = inputs.length;

  int levelAValue = 0;
  int levelBValue = 0;
  int levelCValue = 0;

  int levelA = 0;
  while ((levelA < length) && !found) {
    levelAValue = inputs[levelA];
    int levelB = levelA + 1;
    while (levelB < length && !found) {
      levelBValue = inputs[levelB];
      int levelC = levelB + 1;
      while (levelC < length && !found) {
        levelCValue = inputs[levelC];
        found = (levelCValue + levelBValue + levelAValue== TARGET_VALUE);
        if (!found) levelC++;
      }
      if (!found) levelB++;
    }
    if (!found) levelA++;
  }

  if (found) {
    print("Values: ${levelBValue}, ${levelAValue}, ${levelCValue}");

    print("Answer: ${levelCValue * levelBValue * levelAValue}");
  }
}