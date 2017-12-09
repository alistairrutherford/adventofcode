/**
 * What is the largest value in any register after completing the instructions
 * in your puzzle input?
 *
 */

import 'dart:io';
import 'dart:convert';

const String PROGRAM_FILE = "advent8.txt";

enum ActionType { INC, DEC}

enum ComparisonType {
  LESSTHAN,
  GRATERTHAN,
  LESSTHANOREQUAL,
  GREATERTHANOREQIAL,
  EQUAL
}

/**
 * Instruction: b inc 5 if a > 1
 */
class Instruction {
  String register;
  ActionType action;
  int value;
  String operandA;
  ComparisonType comparison;
  String operandB;

}

/**
 * Model CPU
 */
class CPU {

  Map<String, int> register;

  List<Instruction> instructions;

  void load(String fileName) {

    Directory current = Directory.current;

    String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/advent8.txt";

    var file = new File(path);

    List<String> lines = file.readAsLinesSync(encoding: ASCII);

    for (var l in lines) print (l);
  }

  /**
   * Convert line to instruction.
   *
   */
  Instruction toInstruction(String line) {

  }
}

main(List<String> arguments) {

  CPU cpu = new CPU();

  cpu.load(PROGRAM_FILE);


}