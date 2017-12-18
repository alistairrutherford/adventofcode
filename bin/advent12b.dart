/**
 * Advent 12 (part b).
 *
 * How many groups are there in total?
 *
 */
import 'dart:io';
import 'dart:convert';

const String INPUT_DATA = "advent12input.txt";

class Program {
  String id = "";

  List<Program> children = new List();

  Program(this.id) {
  }
}

/**
 * Define village of programs.
 *
 * 0 <-> 396, 1867
 *
 */
class Village {
  Map<String, Program> programs = new Map();

  /**
   * Count total number of groups.
   *
   */
  int countTotalGroups() {
    int total = 0;

    List<String> keys = programs.keys.toList();
    List<String> programKeys = new List();
    programKeys.addAll(keys);

    for (String id in programKeys) {
      int count = countGroup(id);
      if (count > 1) {
        total++;
      } else {
        print("$id");
      }
    }

    return total;
  }

  /**
   * Count in group.
   *
   */
  int countGroup(String id) {
    Map<String, String> visited = new Map();

    visited.putIfAbsent(id, ()=>id);

    return countUniqueChildren(id, visited);
  }

  /**
   * Traverse associated nodes and count children.
   *
   */
  int countUniqueChildren(String id, Map<String, String> visited, [int curr = 1]) {
    Program node = programs[id];

    if (node != null) {
      for (Program child in node.children) {
        if (visited[child.id] == null) {
          visited.putIfAbsent(child.id, () => child.id);

          programs.remove(id);

          curr = countChildren(child.id, visited, curr + 1);
        }
      }
    }

    return curr;
  }

  /**
   * Traverse associated nodes and count children.
   *
   */
  int countChildren(String id, Map<String, String> visited, [int curr = 1]) {
    Program node = programs[id];
    if (node != null) {
      for (Program child in node.children) {
        if (visited[child.id] == null) {
          visited.putIfAbsent(child.id, () => child.id);

          curr = countChildren(child.id, visited, curr + 1);
        }
      }
    }

    return curr;
  }

  /**
   * Find program in map.
   *
   */
  Program getProgram(String id) {
    Program program = programs[id.trim()];

    if (program == null) {
      program = new Program(id.trim());
      programs.putIfAbsent(id, ()=>program);
    }

    return program;
  }

  /**
   * Load matrix nodes.
   *
   */
  void load(fileName) {
    List<String> lines = loadInput(fileName);

    // Now convert ino tree nodes.
    for (String line in lines) {
      var parts = line.split('<->');
      String id = parts[0].trim();

      Program program = getProgram(id);

      var children = parts[1].split(",");
      for (String child in children) {

        Program childProgram = getProgram(child);

        program.children.add(childProgram);
      }

    }
  }

  /**
   * Load input lines.
   */
  List<String> loadInput(String fileName) {
    Directory current = Directory.current;

    String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

    var file = new File(path);

    List<String> lines = file.readAsLinesSync(encoding: ASCII);

    return lines;
  }

}

main(List<String> arguments) {

  Village village = new Village();

  village.load(INPUT_DATA);

  int count = village.countTotalGroups();

  print("Answer : $count, total: ${village.programs.length}");
}