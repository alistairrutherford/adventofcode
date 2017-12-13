import 'dart:io';
import 'dart:convert';

const String INPUT_DATA = "advent11input.txt";

class PathFinder {

  /**
   * Load steps.
   *
   */
  List<String> load(String fileName) {

    Directory current = Directory.current;

    String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

    var file = new File(path);

    List<String> lines = file.readAsLinesSync(encoding: ASCII);

    List<String> steps = new List();

    for (String line in lines) {
      List<String> parts = line.split(",");
      steps.addAll(parts);
    }

    return steps;
  }

}

main(List<String> arguments) {

  PathFinder pathFinder = new PathFinder();

  pathFinder.load(INPUT_DATA);
}