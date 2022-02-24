/**
 * AdventOfCode 5
 */

import 'dart:collection';
import 'dart:io';
import 'dart:convert';

const String INPUT_FILE = "advent8.txt";

class Sample {
  List<String> signals = List<String>.empty(growable: true);
  List<String> outputs = List<String>.empty(growable: true);

  String getSignal(int index) {
    return signals[index];
  }

  void addSignal(String signal) {
    signals.add(signal);
  }

  void addOutput(String output) {
    outputs.add(output);
  }
  
  String getOutput(int index) {
    return outputs[index];
  }
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
    var signals = parts[0].split(" ");
    var outputs = parts[1].split(" ");
    Sample sample = Sample();
    sample.signals.addAll(signals);
    sample.outputs.addAll(outputs);

    samples.add(sample);
  }

  return samples;
}


/**
 * Main.
 *
 * V : S
 * --|--
 * 0 : 6
 * 1 : 2 *
 * 2 : 5
 * 3 : 5
 * 4 : 4 *
 * 5 : 5
 * 6 : 6
 * 7 : 3 *
 * 8 : 7 *
 * 9 : 6
 */
main(List<String> arguments) {
  // Load data.
  List<Sample> samples = loadInput(INPUT_FILE);

  int total = 0;
  for (Sample sample  in samples) {
    for (String output in sample.outputs) {
      int len = output.trim().length;
      if (len==2||len==3||len==3||len==4||len==7) {
        total++;
      }
    }
  }

  print("Total: $total");
}
