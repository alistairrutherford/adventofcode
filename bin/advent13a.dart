/**
 * Given the details of the firewall you've recorded, if you leave immediately,
 * what is the severity of your whole trip?
 *
 */
import 'dart:io';
import 'dart:convert';

const String INPUT_DATA = "advent13input.txt";

class Layer {
  int depth;
  int range;
  int scanner = 0;

  Layer(this.depth, this.range);

  void step() {
    scanner = (scanner + 1) % range;
  }

  void initialise() {
    scanner = 0;
  }
}

class Firewall {
  List<Layer> layers = new List();

  int packet = 0;
  int cost = 0;

  void addLayer(int depth, int range) {
    Layer layer = new Layer(depth, range);
    layers.add(layer);
  }


  /**
   * Step firewall layers forward
   */
  bool step() {

    // If we already reached the end then reset
    if (packet == layers.length) {
      initialise();
    }

    for (Layer layer in layers) {

      // Are we on a layer with scanner in position 0?
      if (layer.depth == packet && layer.scanner == 0) {
        cost += layer.depth * layer.range;
      }

      layer.step();
    }

    packet++;

    // Are we done;
    bool done = packet == layers.length;

    return done;
  }

  void initialise() {
    // If we already reached the end then reset
    if (packet == layers.length) {
      packet = 0;
      cost = 0;
      for (Layer layer in layers) {
        layer.initialise();
      }
    }
  }

  /**
   * Load layer definitions.
   *
   * 8: 10
   *
   */
  void load(fileName) {
    List<String> lines = loadInput(fileName);

    // Now convert ino tree nodes.
    for (String line in lines) {
      var parts = line.split(":");
      int depth = int.parse(parts[0].trim());
      int range = int.parse(parts[1].trim());

      addLayer(depth, range);
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

  Firewall firewall = new Firewall();

  firewall.load(INPUT_DATA);

  while (!firewall.step());

  print("Total cost: ${firewall.cost}");
}