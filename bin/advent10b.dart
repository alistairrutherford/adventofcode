/**
 * Treating your puzzle input as a string of ASCII characters, what is the Knot
 * Hash of your puzzle input? Ignore any leading or trailing whitespace you
 * might encounter.
 *
 * Help from :
 * http://www.markheath.net/post/advent-of-code-2017-day-11
 * https://www.redblobgames.com/grids/hexagons/#coordinates
 *
               \ n  /
            nw +--+ ne
              /    \
            -+      +-
              \    /
            sw +--+ se
              / s  \

          x, y, z
    "n": [0,1,-1],
    "s": [0,-1,1],
    "nw": [-1,1,0],
    "se": [1,-1,0],
    "ne": [1,0,-1],
    "sw": [-1,0,1],
    }
 */

import 'dart:convert';

var INOUT_STR = "147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70";

List<int> TAIL_SEQ = [17, 31, 73, 47, 23];

const SIZE = 256;

const MAX_ROUND = 64;

class HashArray {
  List<int> data = new List();

  HashArray(int length) {
    for (int i=0; i < length; i++) {
      data.add(i);
    }
  }

  int get(int index) {
    if (index > data.length - 1) {
      index = index % data.length;
    }

    return data[index];
  }

  void put(int index, int value) {
    if (index > data.length - 1) {
      index = index % data.length;
    }

    data[index] = value;
  }


}

/**
 * Main.
 *
 */
main(List<String> arguments) {

  HashArray sparseHashArray = new HashArray(SIZE);

  int current = 0;
  int skip = 0;

  // Build input
  List<int> encoded = ASCII.encode(INOUT_STR);

  List<int> values = new List();
  values.addAll(encoded);
  values.addAll(TAIL_SEQ);

  // Build sparse hash

  for (int round = 0; round < MAX_ROUND; round++) {
    for (int value in values) {
      int count = value ~/ 2;

      for (int i = 0; i < count; i++) {
        int start = current + i;
        int end = current + value - 1 - i;

        int first = sparseHashArray.get(start);
        int last = sparseHashArray.get(end);

        sparseHashArray.put(start, last);
        sparseHashArray.put(end, first);
      }

      current += value + skip++;
      if (current > SIZE) {
        current = current % SIZE;
      }
    }
  }

  // Build dense hash
  List<int> denseHash = new List();
  int block = 0;
  int xor = 0;
  for (int i = 0; i < SIZE; i++) {
    int value = sparseHashArray.get(i);
    xor = xor ^ value;
    block++;

    if (block == 16) {
      denseHash.add(xor);
      block = 0;
      xor = 0;
    }
  }

  String output = "";
  for (int hash in denseHash) {
    var hex = hash.toRadixString(16).padLeft(2, "0");

    output += hex;
  }

  print("$output");
}