/**
 * What is the largest value in any register after completing the instructions
 * in your puzzle input?
 *
 */

import 'dart:io';
import 'dart:convert';

const String PROGRAM_FILE = "advent8.txt";

enum ActionType { INC, DEC, NOP}

enum ComparisonType {
  LESSTHAN,
  GRATERTHAN,
  LESSTHANOREQUAL,
  GREATERTHANOREQIAL,
  EQUAL,
  NOTEQUAL,
  NOP
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
  int operandB;

  Instruction(this.register,
      this.action,
      this.value,
      this.operandA,
      this.comparison,
      this.operandB);
}

/**
 * Model CPU
 */
class CPU {

  Map<String, int> registers;

  Map<String, int> allocation;

  List<Instruction> program;

  CPU() {
    registers = new Map();
    allocation = new Map();
    program = new List();
  }

  /**
   * Convert line to instruction.
   *
   * b inc 5 if a > 1
   *
   */
  Instruction toInstruction(String line) {
    var parts = line.split(' ');

    String register = parts[0].trim();

    String action = parts[1].trim();
    ActionType actionType = toAction(action);

    int value = int.parse(parts[2].trim());

    String comparison = parts[5].trim();
    ComparisonType comparisonType = toComparisonType(comparison);

    String operandA = parts[4].trim();
    int operandB = int.parse(parts[6].trim());

    Instruction instruction = new Instruction(register,
        actionType,
        value,
        operandA,
        comparisonType,
        operandB);

    return instruction;
  }

  /**
   * Convert to comparison type.
   *
   */
  ComparisonType toComparisonType(String comparison) {
    ComparisonType comparisonType = ComparisonType.NOP;
    switch (comparison) {
      case '<':
        comparisonType = ComparisonType.LESSTHAN;
        break;
      case '>':
        comparisonType = ComparisonType.GRATERTHAN;
        break;
      case '<=':
        comparisonType = ComparisonType.LESSTHANOREQUAL;
        break;
      case '>=':
        comparisonType = ComparisonType.GREATERTHANOREQIAL;
        break;
      case '==':
        comparisonType = ComparisonType.EQUAL;
        break;
      case '!=':
        comparisonType = ComparisonType.NOTEQUAL;
        break;
      default:
        comparisonType = ComparisonType.NOP;
        break;
    }

    return comparisonType;
  }

  /**
   * Convert to action type.
   *
   */
  ActionType toAction(String action) {
    ActionType actionType = ActionType.NOP;
    switch (action) {
      case 'inc':
        actionType = ActionType.INC;
        break;
      case 'dec':
        actionType = ActionType.DEC;
        break;
      default:
        actionType = ActionType.NOP;
        break;
    }

    return actionType;
  }


  /**
   * Execute the defined instruction action.
   *
   */
  void executeAction(String register, ActionType action, int value) {
    int currentValue = getRegisterValue(register);

    switch (action) {
      case ActionType.INC:
        currentValue += value;
        break;
      case ActionType.DEC:
        currentValue -= value;
        break;
      default:
      // Nop
        break;
    }

    // Update register.
    registers[register] = currentValue;

    // Track memory allocation.
    int alloc = allocation[register];
    if (currentValue > alloc) {
      allocation[register] = currentValue;
    }
  }

  /**
   * Evaluate the comparison.
   *
   */
  bool evaluate(String register, ComparisonType comparison, int value) {
    bool doAction = false;

    int registerValue = getRegisterValue(register);

    switch (comparison) {
      case ComparisonType.LESSTHAN:
        doAction = registerValue < value;
        break;
      case ComparisonType.GRATERTHAN:
        doAction = registerValue > value;
        break;
      case ComparisonType.LESSTHANOREQUAL:
        doAction = registerValue <= value;
        break;
      case ComparisonType.GREATERTHANOREQIAL:
        doAction = registerValue >= value;
        break;
      case ComparisonType.EQUAL:
        doAction = registerValue == value;
        break;
      case ComparisonType.NOTEQUAL:
        doAction = registerValue != value;
        break;
      default:
        doAction = false;
        break;
    }

    return doAction;
  }

  /**
   * Fetch register value.
   *
   */
  int getRegisterValue(String register) {
    int value = registers[register];

    // If not found then initialise
    if (value == null) {
      registers.putIfAbsent(register, ()=>0);
      allocation.putIfAbsent(register, ()=>0);

      value = 0;
    }

    return value;
  }

  /**
   * Load instructions.
   *
   */
  void load(String fileName) {

    Directory current = Directory.current;

    String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + fileName;

    var file = new File(path);

    List<String> lines = file.readAsLinesSync(encoding: ASCII);

    for (var line in lines) {
      if (!line.trim().isEmpty) {
        Instruction instruction = toInstruction(line);
        program.add(instruction);
      }
    }
  }

  /**
   * Execute loaded program.
   *
   * b inc 5 if a > 1
   *
   */
  void execute() {

    for (Instruction instruction in program) {
      String register = instruction.register;
      ActionType actionType = instruction.action;
      int value = instruction.value;

      String operandA = instruction.operandA;
      ComparisonType comparisonType = instruction.comparison;
      int operandB = instruction.operandB;

      bool doAction = evaluate(operandA, comparisonType, operandB);

      if (doAction) {
        executeAction(register, actionType, value);
      }
    }

  }
}

main(List<String> arguments) {
  CPU cpu = new CPU();

  cpu.load(PROGRAM_FILE);

  cpu.execute();

  List allocations = cpu.allocation.values.toList();
  if (allocations.length > 0) {

    allocations.sort();

    int largest = allocations[allocations.length-1];

    print('Largest value : $largest');
  }

}