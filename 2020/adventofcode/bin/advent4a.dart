/**
 * AdventOfCode 3b
 *
 */
import 'dart:io';
import 'dart:convert';

const String INPUT_DATA = "advent4input.txt";

/**
 * Load input lines.
 */
List<String> loadInput(String fileName) {
  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

  var file = File(path);

  List<String> lines = file.readAsLinesSync(encoding: ascii);

  return lines;
}

/**
 * Build passports list from input rows.
 */
List<String> buildPassports(List<String> rows) {
  List<String> passports = List<String>();

  String concat = '';
  for (String row  in rows) {
    if (row.isNotEmpty) {
      concat += row;
    } else {
      if (concat.isNotEmpty) {
        passports.add(concat);
        concat = '';
      }
    }
  }

  return passports;
}

main(List<String> arguments) {
  List<String> rows = loadInput(INPUT_DATA);

  Map<String, String> REQUIRED = { "byr":"byr", "iyr":"iyr", "eyr":"eyr", "hgt":"hgt", "hcl":"hcl", "ecl":"ecl", "pid":"pid"};

  List<String> passports = buildPassports(rows);

  int total = 0;
  for (String passport in passports) {
    // Split parts
    List<String> parts = passport.split(' ');

    // Split fields and extract labels.
    List<String> labels = List<String>();
    for (String part in parts) {
      var fields = part.split(":");
      if (fields.length == 2) {
        labels.add(fields[0]);
      }
    }

    // Validate labels
    bool valid = true;
    int index = 0;
    while (index < labels.length && valid) {
      String label = labels[index++];
      valid |= REQUIRED[label] != null;
    }
    if (valid) total++;
  }

  print("Total: ${total}");
}