
var INPUT = [147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70];

const SIZE = 256;

class HashArray {
  List<int> data = new List();

  HashArray(int length) {
    for (int i=0; i < length; i++) {
      data.add(i);
    }
  }

  int length() {
    return data.length;
  }

  int get(int index) {
    if (index > data.length) {
      index = index % data.length;
    }

    return data[index];
  }

  void put(int value, int index) {
    if (index > data.length) {
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
  List<int> subValue = new List();
  for (int value in INPUT) {



  }

  print("${hashArray.data.length}");
}