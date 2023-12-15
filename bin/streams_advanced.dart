import 'dart:async';

void main(List<String> args) async {
  // Stream.asyncExpand - Transform each element into a sequence of async events.
  // asyncExpand<E>(Stream<E>? convert(T event)) → Stream<E>
  // Example: Take a stream of strings produced by `getStrings()` and use `asyncExpand` to transform each string into a stream of its characters.
  final streamOfChars = getStrings().asyncExpand(
    (string) => getCharsFromString(string),
  );
  await for (final char in streamOfChars) {
    print(char);
  }

  print('-----------------');

  // Stream.reduce - Combines a sequence of values by repeatedly applying combine.
  // reduce(T combine(T previous, T element)) → Future<T>
  // Example: Take a stream of numbers produced by `getAllNumbers()` and use `reduce` to calculate the sum of all the numbers in the stream.
  final sumOfAges = await getAllNumbers().reduce(
    (previous, element) => previous + element,
  );
  print(sumOfAges);

  print('-----------------');

  // Async Generators with a given predicate (Function with bool return type)
  // Returns a stream of all numbers within the specified range - null/no predicate
  final allNumbersStream = getNumbersWithPredicate();
  await for (final number in allNumbersStream) {
    print(number);
  }

  print('-----------------');

  // Returns a stream of even numbers within the specified range - isEven
  final evenNumbersStream = getNumbersWithPredicate(predicate: isEven);
  await for (final number in evenNumbersStream) {
    print(number);
  }

  print('-----------------');

  // Returns a stream of odd numbers within the specified range - isOdd
  final oddNumbersStream = getNumbersWithPredicate(predicate: isOdd);
  await for (final number in oddNumbersStream) {
    print(number);
  }

  print('-----------------');

  // `capitalizedUsingTransform` uses the `CapitalizeTransformer` to capitalize each string event from the stream.
  // `capitalizedUsingMap` uses the `map` method to capitalize each string event from the stream directly.
  Stream<String> nameStream = Stream.fromIterable([
    'Seth',
    'Kathy',
    'Linda',
    'David',
    'Cynthia',
  ]);

  // Use the `capitalizedUsingTransform` getter to capitalize names from the stream
  final capitalizedStreamUsingTransform = nameStream.capitalizedUsingTransform;
  await for (final name in capitalizedStreamUsingTransform) {
    print(name);
  }

  print('-----------------');

  // Use the `capitalizedUsingMap` getter to capitalize names from the stream
  final capitalizedStreamUsingMap = nameStream.capitalizedUsingMap;
  await for (final name in capitalizedStreamUsingMap) {
    print(name);
  }

  print('-----------------');

  // Consume the stream (nameStream) as list
  final names = await nameStream.toList();
  print(names);

  print('-----------------');

  // Absorbing Stream Errors
  // - Using Stream.handleError()
  print('Using Stream.handleError()');
  final streamWithErrorsAbsorbed =
      getNamesWithErrors().absorbErrorsUsingHandleError;
  await for (final name in streamWithErrorsAbsorbed()) {
    print(name);
  }

  print('-----------------');

  // - Using StreamTransformer.fromHandlers()
  print('Using StreamTransformer.fromHandlers()');
  final streamWithErrorsHandled =
      getNamesWithErrors().absorbErrorsUsingHandlers;
  await for (final name in streamWithErrorsHandled()) {
    print(name);
  }

  print('-----------------');

  // - Using StreamTransformer
  print('Using StreamTransformer');
  final streamWithErrorsTransformed =
      getNamesWithErrors().absorbErrorsUsingTransform;
  await for (final name in streamWithErrorsTransformed()) {
    print(name);
  }

  print('-----------------');

  // Stream.asyncMap - Creates a new stream with each data event of this stream asynchronously mapped to a new event.
  // asyncMap<E>(FutureOr<E> convert(T event)) → Stream<E>
  // Example: Take a stream of strings produced by `getNames()` and use `asyncMap` to transform each string into a stream of its characters.
  // Use fold/reduce to create a sequence of values by repeatedly applying combine.
  final streamOfCharacters = await getNames()
      .asyncMap(
    (string) => getCharsAsync(string),
  )
      .fold('', (previous, element) {
    final elements = element.join(' ');
    return '$previous $elements ';
  });
  print(streamOfCharacters);

  print('-----------------');

  // Non Broadcast Stream vs Broadcast Stream Example
  await nonBroadcastStreamExample();
  print('-----------------');
  await broadcastStreamExample();

  print('-----------------');

  // Timeout Timer Example
  print('Timeout Timer Example');
  try {
    await for (final name in getNamesTimer().withTimeoutBetweenEvents(
      const Duration(
        seconds: 3,
      ),
    )) {
      print(name);
    }
  } on TimeoutBetweenEventsException catch (e) {
    print(e.message);
  }
}

Stream<String> getCharsFromString(String str) async* {
  for (var i = 0; i < str.length; i++) {
    await Future.delayed(Duration(milliseconds: 300));
    yield str[i];
  }
}

Stream<String> getStrings() async* {
  await Future.delayed(Duration(milliseconds: 200));
  yield 'John';
  await Future.delayed(Duration(milliseconds: 200));
  yield 'Doe';
}

Stream<int> getAllNumbers() async* {
  yield 10;
  yield 20;
  yield 30;
  yield 40;
  yield 50;
}

typedef IsIncluded = bool Function(int);

bool isOdd(int number) => number % 2 != 0;
bool isEven(int number) => number % 2 == 0;

Stream<int> getNumbersWithPredicate({
  int start = 0,
  int end = 10,
  IsIncluded? predicate,
}) async* {
  for (var i = start; i < end; i++) {
    if (predicate == null || predicate(i)) {
      yield i;
    }
  }
}

extension CapitalizedStream on Stream<String> {
  Stream<String> get capitalizedUsingTransform => transform(
        CapitalizeTransformer(),
      );

  Stream<String> get capitalizedUsingMap => map((str) => str.toUpperCase());
}

class CapitalizeTransformer extends StreamTransformerBase<String, String> {
  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.map((str) => str.toUpperCase());
  }
}

extension AbsorbErrors<T> on Stream<T> {
  Stream<T> absorbErrorsUsingHandleError() => handleError(
        (_, __) => {},
      );

  Stream<T> absorbErrorsUsingHandlers() =>
      transform(StreamTransformer<T, T>.fromHandlers(
        handleError: (_, __, sink) => {},
      ));

  Stream<T> absorbErrorsUsingTransform() => transform(
        StreamErrorAbsorber(),
      );
}

Stream<String> getNamesWithErrors() {
  final streamController = StreamController<String>();
  streamController.sink.add('Seth');
  streamController.sink.add('Kathy');
  streamController.sink.addError(Exception('Error1'));
  streamController.sink.add('Linda');
  streamController.sink.add('David');
  streamController.sink.addError(Exception('Error2'));
  streamController.sink.add('Cynthia');
  streamController.close();
  return streamController.stream;
}

class StreamErrorAbsorber<T> extends StreamTransformerBase<T, T> {
  @override
  Stream<T> bind(Stream<T> stream) {
    final controller = StreamController<T>();

    stream.listen(
      controller.sink.add,
      onError: (_) => {},
      onDone: controller.close,
      cancelOnError: false,
    );

    return controller.stream;
  }
}

Stream<String> getNames() async* {
  yield 'Seth';
  yield 'Kathy';
  yield 'Linda';
}

Future<List<String>> getCharsAsync(String str) async {
  final chars = <String>[];
  for (final char in str.split('')) {
    await Future.delayed(Duration(milliseconds: 100));
    chars.add(char);
  }
  return chars;
}

Future<void> nonBroadcastStreamExample() async {
  final streamController = StreamController<String>();
  streamController.sink.add('Seth');
  streamController.sink.add('Kathy');
  streamController.sink.add('Linda');
  try {
    await for (final name in streamController.stream) {
      print(name);
      await for (final nameI in streamController.stream) {
        print(nameI);
      }
    }
  } catch (e) {
    print(e);
  }
  streamController.close();
}

Future<void> broadcastStreamExample() async {
  final streamController = StreamController<String>.broadcast();

  final subscription1 = streamController.stream.listen((data) {
    print(data);
  });

  final subscription2 = streamController.stream.listen((data) {
    print(data);
  });

  streamController.sink.add('Seth');
  streamController.sink.add('Kathy');
  streamController.sink.add('Linda');
  await streamController.close();

  streamController.onCancel = () {
    print('Stream has been cancelled');
    subscription1.cancel();
    subscription2.cancel();
  };
}

Stream<String> getNamesTimer() async* {
  yield 'John';
  await Future.delayed(const Duration(seconds: 1));
  yield 'Jane';
  await Future.delayed(const Duration(seconds: 10));
  yield 'Doe';
}

extension WithTimeoutBetweenEvents<T> on Stream<T> {
  Stream<T> withTimeoutBetweenEvents(Duration duration) => transform(
        TimeoutBetweenEvents(
          duration: duration,
        ),
      );
}

class TimeoutBetweenEvents<E> extends StreamTransformerBase<E, E> {
  final Duration duration;

  const TimeoutBetweenEvents({
    required this.duration,
  });

  @override
  Stream<E> bind(Stream<E> stream) {
    StreamController<E>? controller;
    StreamSubscription<E>? subscription;
    Timer? timer;

    controller = StreamController(
      onListen: () {
        subscription = stream.listen(
          (data) {
            timer?.cancel();
            timer = Timer.periodic(
              duration,
              (timer) {
                controller?.addError(
                  TimeoutBetweenEventsException(
                    'Timeout Between Events',
                  ),
                );
              },
            );
            controller?.add(data);
          },
          onError: controller?.addError,
          onDone: controller?.close,
        );
      },
      onCancel: () {
        subscription?.cancel();
        timer?.cancel();
      },
    );

    return controller.stream;
  }
}

class TimeoutBetweenEventsException implements Exception {
  final String message;
  TimeoutBetweenEventsException(this.message);
}
