// A stream, which is of type Stream , is like a series of futures.
// Using a stream enables you to handle data events as they happen rather than waiting for them all to finish.
// You can handle stream errors with listen callbacks or try-catch blocks (await for).
// You can create streams with Stream constructors, asynchronous generators or stream controllers.
// A sink is an object for adding values and errors to a stream.

import 'dart:async';
import 'dart:math';

import 'package:http/http.dart' as http;

/// Challenge 1: Data Stream
///
/// The following code uses the `http` package to stream content from
/// the given URL:
///
/// ```
/// final url = Uri.parse('https://kodeco.com');
/// final client = http.Client();
/// final request = http.Request('GET', url);
/// final response = await client.send(request);
/// final stream = response.stream;
/// ```
///
/// Your challenge is to transform the stream from bytes to strings
/// and see how many bytes each data chunk is. Add error handling,
/// and when the stream is finished, close the client.

Future<void> challenge1UsingListenCallback() async {
  final url = Uri.parse('https://kodeco.com');
  final client = http.Client();
  final request = http.Request('GET', url);
  final response = await client.send(request);
  final stream = response.stream;
  stream.listen(
    (data) => print(data.length),
    onError: (e) => print(e),
    onDone: () => client.close(),
  );
}

Future<void> challenge1UsingTryCatch() async {
  final url = Uri.parse('https://kodeco.com');
  final client = http.Client();
  try {
    final request = http.Request('GET', url);
    final response = await client.send(request);
    final stream = response.stream;
    await for (final data in stream) {
      print(data.length);
    }
  } catch (e) {
    print(e);
  } finally {
    client.close();
  }
}

/// Challenge 2: Heads or Tails?
///
/// Create a coin flipping service that provides a stream of 10 random coin
/// flips, each separated by 500 milliseconds. You use the service like so:
///
/// ```
/// final coinFlipper = CoinFlippingService();
///
/// coinFlipper.onFlip.listen((coin) {
///   print(coin);
/// });
///
/// coinFlipper.start();
/// ```
///
/// `onFlip` is the name of the stream.

enum Coin {
  heads,
  tails,
}

class CoinFlippingService {
  final _controller = StreamController<Coin>();

  Stream<Coin> get onFlip => _controller.stream;

  Future<void> start() async {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(milliseconds: 500), () {
        _controller.sink.add(Coin.values[Random().nextInt(2)]);
      });
    }
    _controller.close();
  }
}

Future<void> challenge2() async {
  final coinFlipper = CoinFlippingService();
  coinFlipper.onFlip.listen(
    (coin) => print(coin.name),
  );
  coinFlipper.start();
}

Future<void> main(List<String> args) async {
  // await challenge1UsingListenCallback();
  // await challenge1UsingTryCatch();
  await challenge2();
}
