void testMethodCallback() {
  print("Before the future");
  Future.delayed(
    Duration(seconds: 1),
    () => 42,
  ).then(
    (value) {
      print('Value: $value');
    },
  ).catchError(
    (error) {
      print('Error: $error');
    },
  ).whenComplete(
    () => print('Done'),
  );
  print("After the future");
}

void testMethodAsyncAwait() async {
  print("Before the future");
  try {
    int value = await Future.delayed(
      Duration(seconds: 1),
      () => 42,
    );
    print('Value: $value');
  } catch (error) {
    print('Error: $error');
  } finally {
    print('Done');
  }
  print("After the future");
}

void main(List<String> args) {
  // testMethodCallback();
  testMethodAsyncAwait();
}
