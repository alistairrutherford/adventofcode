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
   * Count in group.
   *
   */
  int countGroups() {
    int total = 0;

    for (String id in programs.keys) {

      Program program = programs[id];

      // if only one child
      if (program.children.length == 1) {

        // Check to see if only child references parent
        Iterable<Program> look = program.children.where((p)=> p.id == id);

        //If not pointing to parent then group
        if (look.length == 0) {
          total++;
        } else {
          print("$id, ${program.children[0].id}");
        }
      }

    }

    return programs.length - total;
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

        // Look to see if this child doesn't already exist
        Iterable<Program> exists = program.children.where((p)=> p.id == child);

        if (exists.length == 0) {
          program.children.add(childProgram);
        } else {
          print("already exists");
        }

        // Look for this node against child mode
        Iterable<Program> joined = childProgram.children.where((p)=> p.id == id);

        // If found not already linked then link back
        if (joined.length == 0) {
          childProgram.children.add(program);
        } else {
          print("already linked back");
        }

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