/**
 * Advent 12 (part a).
 *
 * How many programs are in the group that contains program ID 0?
 *
 */
import 'dart:io';
import 'dart:convert';

const String INPUT_DATA = "advent12input.txt";
//const String INPUT_DATA = "advent13input.txt";

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
   * Count groups
   */
  int countGroups() {
    List<String> keys  = programs.keys.toList();

    Map<String, String> visited = new Map();

    int count = 0;
    while (keys.isNotEmpty) {
      String id = keys.removeLast();

      walkChildren(id, visited);

      // Remove visited
      for (String groupNode in visited.keys) {
        keys.removeWhere((v) => v == groupNode);
      }

      visited.clear();
      count++;
    }

    return count;
  }

  /**
   * Traverse associated nodes and count children.
   *
   */
  void walkChildren(String id, Map<String, String> visited) {
    Program node = programs[id];

    for (Program child in node.children) {
      if (visited[child.id] == null) {
        visited.putIfAbsent(child.id, () => child.id);

        walkChildren(child.id, visited);
      }
    }

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

        Program childProgram = getProgram(child.trim());

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

  int count = village.countGroups();

  print("Answer : $count");
}