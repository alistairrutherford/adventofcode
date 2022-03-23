/**
 * AdventOfCode 9
 */

import 'dart:collection';
import 'dart:io';
import 'dart:convert';

const String INPUT_FILE = "advent9.txt";

/**
 * Load input and build data stricture
 *
 */
List<Node> loadInput(String fileName) {
  List<Node> nodes = List<Node>.empty(growable: true);

  Directory current = Directory.current;
  String path = current.toString().split(' ')[1].replaceAll('\'', '') +
      "/bin/" + fileName;
  var file = File(path);
  List<String> lines = file.readAsLinesSync(encoding: ascii);

  int gridX = 0;
  // Read all the values in the grid
  for (String line in lines) {
    gridX = line.length;
    // Read individual heights
    for (int index = 0; index < line.length; index++) {
      Node node = Node(int.parse(line[index]));
      nodes.add(node);
    }
  }

  // Build nodes
  int rows = (nodes.length ~/ gridX);
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < gridX; col++) {
      int current = col + (row * gridX);
      Node currentNode = nodes[current];
      if (col > 0) {
        currentNode.leftNode = nodes[current - 1];
      }
      if (col < gridX - 1) {
        currentNode.rightNode = nodes[current + 1];
      }
      if (row > 0) {
        currentNode.upNode = nodes[current - gridX];
      }
      if (row < rows - 1) {
        currentNode.downNode = nodes[current + gridX];
      }
    }
  }

  return nodes;
}

class Node {
  late int value;

  Node? leftNode;
  Node? rightNode;
  Node? upNode;
  Node? downNode;

  // Initialise node
  Node(this.value);

  ///
  /// Check if this node is the lowest to adjacent nodes.
  ///
  bool isLowest() {
    bool state = false;

    state = true;

    if (leftNode != null) {
      int left = leftNode!.value;
      state &= value < left;
    }

    if (rightNode != null) {
      int right = rightNode!.value;
      state &= value < right;
    }

    if (upNode != null) {
      int up = upNode!.value;
      state &= value < up;
    }

    if (downNode != null) {
      int down = downNode!.value;
      state &= value < down;
    }

    return state;
  }
}


  /**
   * Main.
   */
  main(List<String> arguments) {
    // Load data.
    List<Node> nodes = loadInput(INPUT_FILE);

    int total = 0;
    for (Node node in nodes) {
      if (node.isLowest()) {
        total += node.value + 1;
      }
    }

    print("Total: $total");
  }
