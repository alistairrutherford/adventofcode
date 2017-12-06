/**
 * Given the initial block counts in your puzzle input, how many redistribution
 * cycles must be completed before a configuration is produced that has been
 * seen before?
 */
var MEMORY_BANK = [4, 1, 15, 12, 0, 9, 9, 5, 5, 8, 7, 3, 14, 5, 12, 3];

main(List<String> arguments) {
  int cycle = 0;

  Map<String, String> snapshot = new Map();

  String memoryMap = MEMORY_BANK.toString();

  int memLength = MEMORY_BANK.length;

  // Make initial snapshot
  snapshot.putIfAbsent(memoryMap, ()=>memoryMap);

  bool finished = false;
  bool found = false;
  while (!finished) {
    int top = topBank();

    int blocks = MEMORY_BANK[top];

    MEMORY_BANK[top] = 0;

    int memIndex = (top + 1) % memLength;

    for (int block = 0; block < blocks; block++) {
      int newBlock = MEMORY_BANK[memIndex] + 1;

      MEMORY_BANK[memIndex] = newBlock;

      memIndex = (memIndex + 1) % memLength;
    }

    memoryMap = MEMORY_BANK.toString();

    // Look for same arrangement of memory banks
    if (snapshot.containsKey(memoryMap)) {
      if (found) {
        finished = true;
      } else {
        // initialize for second loop.
        snapshot.clear();
        memoryMap = MEMORY_BANK.toString();
        snapshot.putIfAbsent(memoryMap, ()=>memoryMap);
        found = true;
        cycle = 1;
      }

    } else {
      snapshot.putIfAbsent(memoryMap, ()=>memoryMap);
      cycle++;
    }

  }

  print('Cycles : $cycle');
}

/**
 * Find top bank, the long way.
 */
int topBank() {
  int top = 0;
  int target = 0;

  for (int index = 0; index < MEMORY_BANK.length; index++) {
    int curr = MEMORY_BANK[index];
    if (curr > top) {
      target = index;
      top = curr;
    }
  }

  return target;
}