// You can create a stream in a few ways:
// - Using Stream constructors.
// - Using asynchronous generators.
// - Using stream controllers.

// Using Stream constructors
// - Stream.periodic
// - Stream.empty
// - Stream.value
// - Stream.error
// - Stream.fromFuture
// - Stream.fromFutures
// - Stream.fromIterable

import 'dart:async';

Stream<String> getStreamFromIterable() {
  return Stream.fromIterable(['a', 'b', 'c']);
}

Stream<String> getStreamFromFuture() {
  return Stream.fromFuture(Future.delayed(Duration(seconds: 1), () => 'a'));
}

Stream<String> getStreamFromFutures() {
  return Stream.fromFutures([
    Future(() => '0'),
    Future.delayed(Duration(seconds: 1), () => 'a'),
    Future.delayed(Duration(seconds: 1), () => 'b'),
    Future.delayed(Duration(seconds: 1), () => 'c'),
    Future(() => '1'),
  ]);
}

// Review Synchronous Generators

Iterable<int> reviewSyncGenerator() sync* {
  print("Numbers: ");
  for (int i = 0; i < 10; i++) {
    yield i;
  }
  print("Squares: ");
  yield* squares();
}

Iterable<int> squares() sync* {
  for (int i = 0; i < 10; i++) {
    yield i * i;
  }
}

// Using asynchronous generators

Stream<String> getStreamFromAsyncGenerator() async* {
  final data = ['a', 'b', 'c', 'd', 'e', 'f'];
  for (final d in data) {
    await Future.delayed(Duration(seconds: 1));
    yield d;
  }
  yield* asciiCodes();
}

Stream<String> asciiCodes() async* {
  final data = ['a', 'b', 'c', 'd', 'e', 'f'];
  for (final d in data) {
    await Future.delayed(Duration(seconds: 1));
    yield d.codeUnitAt(0).toString();
  }
}

// Using stream controllers

void createStreamFromController() {
  final controller = StreamController<String>();
  final stream = controller.stream;
  final sink = controller.sink;
  stream.listen(
    (event) => print(event),
    onError: (e) => print(e),
    onDone: () => print('Sink closed!'),
    cancelOnError: false,
  );
  sink.add('a');
  sink.add('b');
  sink.addError(Exception('Error1'));
  sink.add('c');
  sink.add('d');
  sink.add('e');
  sink.addError(Exception('Error2'));
  sink.add('f');
  sink.close();
}

Stream<String> getStreamFromController() {
  final controller = StreamController<String>();
  final data = ['a', 'b', 'c', 'd', 'e', 'f'];
  data.forEach(controller.sink.add);
  return controller.stream;
}

void main(List<String> args) {
  // getStreamFromIterable().forEach(print);
  // getStreamFromFuture().forEach(print);
  // getStreamFromFutures().forEach(print);

  // reviewSyncGenerator().forEach(print);

  // getStreamFromAsyncGenerator().forEach(print);

  // createStreamFromController();
  getStreamFromController().forEach(print);
}
