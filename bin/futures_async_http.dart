import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo(
      {required this.userId,
      required this.id,
      required this.title,
      required this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }

  @override
  String toString() {
    return 'userId: $userId\n'
        'id: $id\n'
        'title: $title\n'
        'completed: $completed';
  }
}

Future<void> getTodoTheory() async {
  try {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
    final response = await http.get(url);
    final statusCode = response.statusCode;
    if (statusCode != 200) {
      throw HttpException('$statusCode');
    }
    dynamic jsonMap = jsonDecode(response.body);
    print(Todo.fromJson(jsonMap));
  } on SocketException catch (e) {
    // You’ll get this exception if there’s no internet connection.
    // The http.get method is the one to throw the exception.
    print(e);
  } on HttpException catch (e) {
    // You’re throwing this exception yourself if the status code isn’t 200 OK.
    print(e);
  } on FormatException catch (e) {
    // jsonDecode throws this exception if the JSON string from the server
    // isn’t in proper JSON format.
    print(e);
  }
}

Future<void> fromFutureExercise() async {
  try {
    final message = await Future.delayed(
      const Duration(seconds: 2),
      () => 'I am from future',
    );
    print(message);
  } on Exception catch (e) {
    print(e);
  }
}

Future<void> main(List<String> args) async {
  await getTodoTheory();
  // await fromFutureExercise();
}
