/**
 * AdventOfCode 5
 */

import 'dart:collection';
import 'dart:io';
import 'dart:convert';

const String INPUT_FILE = "advent8b.txt";

/**
 * Sort input string letters alphabetically.
 */
String sortString(String input) {
  List<String> letters = List<String>.empty(growable: true);
  for (int index = 0; index < input.length; index++) {
    letters.add(input[index]);
  }
  letters.sort();
  String ordered = "";
  for (String letter in letters) {
    ordered += letter;
  }
  return ordered;
}

/**
 * Count the number of shared digits between strings
 */
int sharedDigits(var numberString, String inputString) {
  int shared = 0;

  for (int index = 0; index < numberString.length; index++) {
      if (inputString.contains(numberString[index])) {
        shared++;
      }
  }
  return shared;
}

class Sample {
  List<String> signals = List<String>.empty(growable: true);
  List<String> outputs = List<String>.empty(growable: true);
}


/**
 * Load input.
 */
List<Sample> loadInput(String fileName) {
  List<Sample> samples = List<Sample>.empty(growable: true);

  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

  var file = File(path);

  List<String> lines = file.readAsLinesSync(encoding: ascii);

  for (String line in lines) {
    var parts = line.trim().split("|");
    var signals = parts[0].trim().split(" ");
    var outputs = parts[1].trim().split(" ");
    Sample sample = Sample();
    sample.signals.addAll(signals);
    sample.outputs.addAll(outputs);

    // Sort the values and rebuild the lists.
    var temp = sample.signals.map((e) => sortString(e)).toList();
    sample.signals.replaceRange(0, sample.signals.length, temp);
    temp = sample.outputs.map((e) => sortString(e)).toList();
    sample.outputs.replaceRange(0, sample.outputs.length, temp);

    samples.add(sample);
  }

  return samples;
}


/**
 * Main.
 */
main(List<String> arguments) {
  // Load data.
  List<Sample> samples = loadInput(INPUT_FILE);

  int total = 0;

  HashMap<String, String> CODE = HashMap<String, String>();
  HashMap<int, String> VALUE = HashMap<int, String>();

  // Pull out the ones we know.
  for (Sample sample  in samples) {

    CODE.clear();
    VALUE.clear();

    for (String signal in sample.signals) {
      int len = signal.length;
      switch (len) {
        case 2:
          CODE[signal] = "1";
          VALUE[1] = signal;
          break;
        case 3:
          CODE[signal] = "7";
          VALUE[7] = signal;
          break;
        case 4:
          CODE[signal] = "4";
          VALUE[4] = signal;
          break;
        case 7:
          CODE[signal] = "8";
          VALUE[8] = signal;
          break;
      }
    }

    // Now determine the rest
    for (String signal in sample.signals) {

      int sharedWith1 = sharedDigits(VALUE[1], signal);
      int sharedWith4 = sharedDigits(VALUE[4], signal);
      int sharedWith7 = sharedDigits(VALUE[7], signal);
      int sharedWith8 = sharedDigits(VALUE[8], signal);

      if (sharedWith1==2 && sharedWith4==3 && sharedWith7==3 && sharedWith8==6) {
        CODE[signal] = "0";
        VALUE[0] = signal;
      } else if (sharedWith1==1 && sharedWith4==2 && sharedWith7==2 && sharedWith8==5) {
        CODE[signal] = "2";
        VALUE[2] = signal;
      } else if (sharedWith1==2 && sharedWith4==3 && sharedWith7==3 && sharedWith8==5) {
        CODE[signal] = "3";
        VALUE[3] = signal;
      } else if (sharedWith1==1 && sharedWith4==3 && sharedWith7==2 && sharedWith8==5) {
        CODE[signal] = "5";
        VALUE[5] = signal;
      } else if (sharedWith1==1 && sharedWith4==3 && sharedWith7==2 && sharedWith8==6) {
        CODE[signal] = "6";
        VALUE[6] = signal;
      } else if (sharedWith1==2 && sharedWith4==4 && sharedWith7==3 && sharedWith8==6) {
        CODE[signal] = "9";
        VALUE[9] = signal;
      }
    }

    String composed = "0";
    for (String output in sample.outputs) {
      String? value = CODE[output];
      if (value != null) {
        composed += value;
      }
    }
    total += int.parse(composed);
  }

  print("Total: $total");
}
