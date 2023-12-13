import 'dart:convert';
import 'dart:io';

Future<void> readFileAsString() async {
  final file = File('assets/text.txt');
  final contents = await file.readAsString();
  print(contents);
}

Future<void> readFileAsStream() async {
  final file = File('assets/text.txt');
  final stream = file.openRead();
  final contents = stream.transform(utf8.decoder);
  await for (final line in contents) {
    print(line);
  }
}

Future<void> readFileAsStreamListenCallback() async {
  final file = File('assets/long_text.txt');
  final stream = file.openRead();
  stream.listen(
    (data) {
      if (data.length > 50000) {
        print(data.length);
      } else {
        print('Data chunk size less than 50k bytes');
      }
    },
    onError: (error) {
      print('An error occurred: $error');
    },
    cancelOnError: true,
    onDone: () {
      print('Done');
    },
  );
}

Future<void> readFileAsStreamAsyncForLoop() async {
  try {
    final file = File('assets/long_text.txt');
    final stream = file.openRead();
    await for (final data in stream) {
      if (data.length > 50000) {
        print(data.length);
      } else {
        throw Exception('Data chunk size less than 50k bytes');
      }
    }
  } on Exception catch (e) {
    print(e);
  } finally {
    print('Done');
  }
}

Future<void> periodicStream() async {
  final stream = Stream<int>.periodic(
    Duration(seconds: 1),
    (count) => count,
  ).take(10);
  await for (final value in stream) {
    print(value);
  }
}

Future<void> main(List<String> args) async {
  // await readFileAsString();
  // await readFileAsStream();
  // await readFileAsStreamListenCallback();
  // await readFileAsStreamAsyncForLoop();
  await periodicStream();
}
