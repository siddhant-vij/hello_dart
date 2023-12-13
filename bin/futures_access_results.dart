import 'package:http/http.dart' as http;

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

void getHttpResultCallback() {
  var url = Uri.https('www.example.com');
  http.get(url).then((response) {
    if (response.statusCode == 200) {
      print("Response OK");
    } else {
      print("Response failed");
    }
  }).catchError((error) {
    print("Request failed: $error");
  }).whenComplete(() {
    print('Done');
  });
}

void getHttpResultAsyncAwait() async {
  var url = Uri.https('www.example.com');
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print("Response OK");
    } else {
      print("Response failed");
    }
  } catch (error) {
    print("Request failed: $error");
  } finally {
    print('Done');
  }
}

void main(List<String> args) {
  // testMethodCallback();
  // testMethodAsyncAwait();
  // getHttpResultCallback();
  getHttpResultAsyncAwait();
}
