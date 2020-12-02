/**
 * what is the result of multiplying the first two numbers in the list?
 *
 */

var INPUT = [147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70];


const SIZE = 256;

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

  HashArray hashArray = new HashArray(SIZE);

  int current = 0;
  int skip = 0;

  for (int value in INPUT) {

    int count = value ~/ 2;

    for (int i = 0; i < count; i++) {

      int start = current + i;
      int end = current + value - 1 - i;

      int first = hashArray.get(start);
      int last = hashArray.get(end);

      hashArray.put(start, last);
      hashArray.put(end, first);
    }

    current += value + skip++;
    if (current > SIZE) {
      current = current % SIZE;
    }
  }

  int first = hashArray.get(0);
  int second = hashArray.get(1);
  int mult = first * second;

  print("$first, $second, $mult");
}