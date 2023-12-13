/// Using a future, which is of type Future , tells Dart that it may reschedule the requested task on the event loop.
/// When a future completes, it will contain either the requested value or an error.
/// A method that returns a future doesn’t necessarily run on a different process or thread. That depends entirely on the implementation.
/// You can handle errors from futures with callbacks or try-catch blocks.
/// You can create a future using a named or unnamed Future constructor, returning a value from an async method or using a Completer.

import 'dart:math';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Challenge 1: Spotty Internet
///
/// Implement `FakeWeatherServer.fetchTemperature` so it completes sometimes
/// with a value and sometimes with an error.
/// Use `Random` to help you.

class WeatherServerNotConnected implements Exception {
  @override
  String toString() {
    return 'Web server not connected';
  }
}

abstract class DataRepository {
  Future<double> fetchTemperature(String city);
}

class FakeWeatherServer implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) {
    return Future.delayed(
      Duration(seconds: 2),
      () {
        var random = Random();
        var isError = random.nextBool();
        if (isError) {
          throw WeatherServerNotConnected();
        } else {
          return random.nextDouble() * 50;
        }
      },
    );
  }
}

Future<void> checkWeather(DataRepository server, String city) async {
  try {
    var temperature = await server.fetchTemperature(city);
    print("Temperature in $city is $temperature");
  } on WeatherServerNotConnected catch (e) {
    print(e);
  }
}

Future<void> challenge1() async {
  var server = FakeWeatherServer();
  await checkWeather(server, 'London');
  await checkWeather(server, 'Portland');
  await checkWeather(server, 'TestCity');
  await checkWeather(server, 'New York');
}

/// Challenge 2: What's the Temperature?
///
/// Use a real web api to get the temperature and implement the
/// `DataRepository` interface from the lesson.
///
/// [Free Code Camp](https://www.freecodecamp.org/) has a weather API that
/// takes the following form:
///
/// https://fcc-weather-api.glitch.me/api/current?lat=45.5&lon=-122.7
///
///
/// You can change the numbers after `lat` and `lon` to specify latitude and
/// longitude for the weather.
///
/// Complete the following steps to find the weather:
///
/// 1. Convert the URL above to a Dart `Uri` object.
/// 2. Use the http package to make a GET request. This will give you a `Response` object.
/// 3. Use the `response.body` to get the JSON string.
/// 4. Decode the JSON string into a Dart map.
/// 5. Print the map and look for the temperature.
/// 6. Extract the temperature and the city name from the map.
/// 7. Print the weather report as a sentence.
/// 8. Add error handling.

Future<void> challenge2(double lat, double lon) async {
  final baseUrl = 'https://fcc-weather-api.glitch.me/api/current';
  final url = Uri.parse('$baseUrl?lat=$lat&lon=$lon');
  try {
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw WeatherServerNotConnected();
    }
    final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
    final temperature = jsonMap['main']['temp'] as double;
    final city = jsonMap['name'] as String;
    print("Temperature in $city is $temperature");
  } on SocketException catch (e) {
    print(e);
  } on WeatherServerNotConnected catch (e) {
    print(e);
  } on FormatException catch (e) {
    print(e);
  }
}

/// Challenge 3: Care to Make a Comment?
///
/// The following link returns a JSON list of comments:
///
/// https://jsonplaceholder.typicode.com/comments
///
/// Create a `Comment` data class and convert the raw JSON to a Dart list
/// of type `List<Comment>`.

class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postId: json['postId'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      body: json['body'] as String,
    );
  }

  @override
  String toString() {
    return 'postId: $postId\n'
        'id: $id\n'
        'name: $name\n'
        'email: $email\n'
        'body: $body\n';
  }
}

Future<void> challenge3() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
  try {
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw WeatherServerNotConnected();
    }
    final jsonList = jsonDecode(response.body) as List<dynamic>;
    final commentList = jsonList
        .map((json) => Comment.fromJson(json as Map<String, dynamic>))
        .toList();
    print(commentList.length);
  } on SocketException catch (e) {
    print(e);
  } on WeatherServerNotConnected catch (e) {
    print(e);
  } on FormatException catch (e) {
    print(e);
  }
}

Future<void> main(List<String> args) async {
  // await challenge1();
  // await challenge2(45.5, -122.7);
  await challenge3();
}
