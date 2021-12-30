/**
* AdventOfCode 1
*/

import 'dart:collection';
import 'dart:io';
import 'dart:convert';

const String INPUT_DATA = "advent1a.txt";

/**
 * Load input lines.
 */
List<int> loadInput(String fileName) {
  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

  var file = File(path);

  List<String> lines = file.readAsLinesSync(encoding: ascii);

  List<int> listOfInts = <int>[];
  for (String value in lines) {
    listOfInts.add(int.parse(value));
  }

  return listOfInts;
}

main(List<String> arguments) {

  List<int> inputs = loadInput(INPUT_DATA);

  Queue<int> queue = Queue<int>();

  int countIncreased = 0;
  int lastSum = -1;
  int thisSum = 0;
  for (int value in inputs) {
    queue.addFirst(value);
    if (queue.length == 3) {
      thisSum = 0;
      for (var element in queue) { thisSum += element;}

      if (lastSum != -1) {
        if (thisSum > lastSum) {
          countIncreased++;
        }
      }

      lastSum = thisSum;

      queue.removeLast();
    }
  }

  print("Increase: $countIncreased");

}