import 'dart:io';
import 'dart:async';

/// A simple class to hold the start and end values of a range.
class NumberRange {
  final int start;
  final int end;

  NumberRange(this.start, this.end);

  @override
  String toString() => 'Range(Start: $start, End: $end)';
}

/// Checks if a number is composed of a repeated pattern of contiguous digits.
/// Example: 446446 is valid because "446" is repeated twice.
/// Example: 222222 is valid because "2" is repeated 6 times (or "22" 3 times).
bool hasRepeatedPattern(int number) {
  String s = number.toString();
  int len = s.length;

  // Iterate through possible pattern lengths that, when repeated, can form the whole number.
  // To be repeated AT LEAST twice, the pattern length must be <= len / 2.
  for (int patternLength = 1; patternLength <= len ~/ 2; patternLength++) {
    // Check if the total length is a multiple of the potential pattern length.
    if (len % patternLength == 0) {
      String pattern = s.substring(0, patternLength);
      int repeats = len ~/ patternLength;

      // Since patternLength <= len / 2, 'repeats' will be >= 2, satisfying the "at least twice" rule.

      // Reconstruct the number by repeating the pattern
      // Using List.filled().join('') is the correct Dart idiom for string repetition.
      String repeatedString = List.filled(repeats, pattern).join('');

      if (repeatedString == s) {
        // Found a pattern that repeats two or more times.
        return true;
      }
    }
  }

  return false;
}

/// Parses a CSV file containing ranges (e.g., "10-20, 30-40").
/// Handles splitting by commas and newlines.
Future<List<NumberRange>> parseRangeFile(String filePath) async {
  final file = File(filePath);
  final List<NumberRange> ranges = [];

  if (!await file.exists()) {
    throw FileSystemException('File not found', filePath);
  }

  // Read the entire file as a single string
  String contents = await file.readAsString();

  // 1. Split the content by both commas (,) and newlines (\n or \r\n)
  List<String> rawTokens = contents.split(RegExp(r'[,\n\r]+'));

  for (String token in rawTokens) {
    // Clean up whitespace
    String cleanToken = token.trim();

    if (cleanToken.isEmpty) continue;

    // 2. Split the specific range format "Start-End"
    List<String> parts = cleanToken.split('-');

    if (parts.length == 2) {
      try {
        int start = int.parse(parts[0]);
        int end = int.parse(parts[1]);
        ranges.add(NumberRange(start, end));
      } catch (e) {
        print('Warning: Could not parse integers from token "$cleanToken"');
      }
    } else {
      print('Warning: Invalid format for token "$cleanToken". Expected "start-end".');
    }
  }

  return ranges;
}

void main() async {
  const String filename = 'advent2b.txt';

  Directory current = Directory.current;

  String filePath = current.toString().split(' ')[1].replaceAll('\'','') + "/bin/" + filename;

  // --- STEP 2: Read and Parse the file ---
  try {
    List<NumberRange> parsedRanges = await parseRangeFile(filePath);
    int totalMatchSum = 0; // Variable to store the cumulative sum of matches

    print('Processing ${parsedRanges.length} ranges for repeated patterns...\n');

    for (var range in parsedRanges) {
      print('Checking $range:');
      bool found = false;

      // Iterate through every number in the range (inclusive)
      for (int i = range.start; i <= range.end; i++) {
        if (hasRepeatedPattern(i)) {
          print('  [MATCH] $i');
          totalMatchSum += i; // Add the matched number to the total sum
          found = true;
        }
      }

      if (!found) {
        print('  No matches found.');
      }
      print(''); // Empty line for readability
    }

    // --- STEP 3: Print the final sum ---
    print('-----------------------------------');
    print('Total sum of all matched repeated-pattern numbers: $totalMatchSum');

  } catch (e) {
    print('Error: $e');
  }
}
