import 'dart:io';
import 'dart:convert';
import 'dart:async';

const String GROUP_START = "{";
const String GROUP_END = "}";
const String GARBAGE_START ="<";
const String GARBAGE_END = ">";
const String NULL_CHAR = "!";

const String FILE_NAME = "advent9input.txt";

class StreanProcessor {

}

main(List<String> arguments) {

  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + FILE_NAME;

  Stream<List<int>> stream = new File(path).openRead();

  stream.transform(UTF8.decoder)
      .listen((value) {

    String char = value;
    stdout.write(char);
  });


}