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
  int value;
  bool visited = false;

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

///
/// Traverse the basin nodes adjacent to starting node and count the number of
/// valid nodes.
///
int basinCount(Node? node, [int current = 0]) {

  int total = current;

  if (node != null && node.value != 9) {
    print("value: ${node.value}");

    if (!node.visited) {
      total++;
      node.visited = true;
    }

    Node? leftNode = node.leftNode;
    if (leftNode != null && !leftNode.visited) {
      total += basinCount(node.leftNode);
    }

    Node? rightNode = node.rightNode;
    if (rightNode != null && !rightNode.visited) {
      total += basinCount(node.rightNode);
    }

    Node? upNode = node.upNode;
    if (upNode != null && !upNode.visited) {
      total += basinCount(node.upNode);
    }

    Node? downNode = node.downNode;
    if (downNode != null && !downNode.visited) {
      total += basinCount(node.downNode);
    }
  }
  return total;
}

  /**
   * Main.
   */
  main(List<String> arguments) {
    // Load data.
    List<Node> nodes = loadInput(INPUT_FILE);
    List<int> counts = List<int>.empty(growable: true);

    // Find lowest starting points.
    for (Node node in nodes) {
      if (node.isLowest()) {
        int basinSize = basinCount(node);
        print("Size: $basinSize");
        counts.add(basinSize);
      }
    }

    // Sort in descending order.
    counts.sort((b, a) => a.compareTo(b));

    // Pull out top 3 results and generate result.
    int total = 1;
    if (counts.length >=3) {
      for (int index = 0; index < 3; index++) {
        print("count: ${counts[index]}");
        total *= counts[index];
      }
    }
    print("total: $total");
  }
