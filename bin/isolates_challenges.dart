// You can run Dart code on another thread by spawning a new isolate.
// Dart isolates don’t share any mutable memory state and communicate only through messages.
// You can pass multiple arguments to an isolate’s entry-point function using a list or a map.
// Use a ReceivePort to listen for messages from another isolate.
// Use a SendPort to send messages to another isolate.
// For long-running isolates, you can set up two-way communication by creating a send port and receive port for both isolates.

import 'dart:convert';
import 'dart:isolate';

/// Challenge 1: Fibonacci From Afar
///
/// Calculate the nth Fibonacci number. The Fibonacci sequence starts with 1,
/// then 1 again, and then all subsequent numbers in the sequence are simply
/// the previous two values in the sequence added together (1, 1, 2, 3, 5, 8...).
///
/// Run the code in a separate isolate. Pass the value of n to the new
/// isolate as an argument, and send the result back to the main isolate.

void findNthFibonacci(List<Object> args) {
  final sendPort = args[0] as SendPort;
  final n = args[1] as int;
  var current = 1;
  var previous = 1;
  var done = 2;
  while (done < n) {
    final next = current + previous;
    previous = current;
    current = next;
    done++;
  }
  Isolate.exit(sendPort, current);
}

Future<void> challenge1(int n) async {
  final receivePort = ReceivePort();
  await Isolate.spawn(
    findNthFibonacci,
    [
      receivePort.sendPort,
      n,
    ],
  );
  final result = await receivePort.first as int;
  print(result);
}

/// Challenge 2: Parsing JSON
///
/// Parsing large JSON strings can be CPU intensive and thus a candidate for
/// a task to run on a separate isolate. The following JSON string isn't
/// particularly large, but convert it to a map on a separate isolate:
///
/// ```
/// const jsonString = '''
/// {
///   "language": "Dart",
///   "feeling": "love it",
///   "level": "intermediate"
/// }
/// ''';
/// ```

void parseJson(List<Object> args) {
  final sendPort = args[0] as SendPort;
  final jsonString = args[1] as String;
  final jsonMap = jsonDecode(jsonString);
  sendPort.send(jsonMap);
}

Future<void> challenge2(String jsonString) async {
  final receivePort = ReceivePort();
  await Isolate.spawn(
    parseJson,
    [
      receivePort.sendPort,
      jsonString,
    ],
  );
  final result = await receivePort.first as Map<String, dynamic>;
  print(result);
}

Future<void> main() async {
  await challenge1(6);
  // --------------------------
  const jsonString = '''
    {
      "language": "Dart",
      "feeling": "love it",
      "level": "intermediate"
    }
    ''';
  await challenge2(jsonString);
}
