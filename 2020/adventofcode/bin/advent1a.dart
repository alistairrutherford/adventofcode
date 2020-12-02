/**
 * Given the details of the firewall you've recorded, if you leave immediately,
 * what is the severity of your whole trip?
 *
 */
import 'dart:io';
import 'dart:convert';

  const String INPUT_DATA = "advent1a.txt";

/**
 * Load input lines.
 */
List<String> loadInput(String fileName) {
  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

  var file = new File(path);

  List<String> lines = file.readAsLinesSync(encoding: ascii);

  return lines;
}

main(List<String> arguments) {

  List<String> inputs = loadInput(INPUT_DATA);

  print("Lines read: ${inputs.length}");
}