import 'package:characters/characters.dart';
import 'dart:math';
import 'package:json_annotation/json_annotation.dart';
// import 'dart:io';

part 'hello_null_collections.g.dart';
// dart run build_runner build

class Sphere {
  final int? _radius;

  const Sphere({required int radius}) : _radius = radius;

  double get volume => 4 / 3 * pi * _radius! * _radius! * _radius!;
  double get surfaceArea => 4 * pi * _radius! * _radius!;
}

class TempClass {
  String? stringOrNull = Random().nextBool() ? "Hello" : null;

  void myMethod() {
    // if (stringOrNull is String) {
    //   print(stringOrNull?.length);
    // } else {
    //   print(0);
    // }
    print(stringOrNull?.length ?? 0);
  }
}

int generateRandom() {
  return (Random().nextBool() ? 100 : null) ?? 0;
}

int tempTest(int? number) {
  return number ?? 0;
}

void exercise1() {
  String? profession;
  print(profession);
  profession = "Basketball Player";
  print(profession);
}

class Name {
  String? givenName;
  String? surname;
  bool? surnameIsFirst;

  Name(
      {required this.givenName,
      this.surname = "",
      this.surnameIsFirst = false});

  @override
  String toString() {
    if (surname == "") {
      return "$givenName";
    } else {
      if (surnameIsFirst!) {
        return "$surname $givenName";
      } else {
        return "$givenName $surname";
      }
    }
  }
}

List<int> filterEven(List<int> list) {
  return list.where((element) => element % 2 == 0).toList();
}

List<String> filterDays(List<String> list) {
  return list.where((element) => element.startsWith("S")).toList();
}

class Task {
  String? _name;
  String? _description;
  bool? _isDone;

  Task({required name, description, isDone = false}) {
    _name = name;
    _description = description;
    _isDone = isDone;
  }

  @override
  String toString() {
    return "Name: $_name\nDescription: $_description\nIs Done: $_isDone";
  }
}

// class AppToDo {
//   Set<Task>? _tasks;

//   void addTask(Task task) {
//     _tasks ??= {};
//     _tasks!.add(task);
//   }

//   void removeTask(String task) {
//     if (_tasks != null) {
//       int initialLength = _tasks!.length;
//       _tasks!.removeWhere((t) => t._name == task);
//       if (_tasks!.length == initialLength) {
//         print("Task not found");
//       }
//     } else {
//       print("No tasks to remove");
//     }
//   }

//   void viewTasks() {
//     _tasks?.forEach((task) => print(task));
//     if (_tasks?.isEmpty ?? true) {
//       print("No tasks to view");
//     }
//   }
// }

class AppToDo {
  Map<String?, Task>? _tasks;

  void addTask(Task task) {
    _tasks ??= {};
    _tasks![task._name] = task;
  }

  void removeTask(String task) {
    if (_tasks != null) {
      if (_tasks!.remove(task) == null) {
        print("Task not found");
      }
    } else {
      print("No tasks to remove");
    }
  }

  void viewTasks() {
    if (_tasks?.isEmpty ?? true) {
      print("No tasks to view");
    } else {
      for (var task in _tasks!.values) {
        print(task);
      }
    }
  }
}

String longestAndShortest(List<String> list) {
  String longest = list[0];
  String shortest = list[0];
  for (int i = 1; i < list.length; i++) {
    if (list[i].length > longest.length) {
      longest = list[i];
    }
    if (list[i].length < shortest.length) {
      shortest = list[i];
    }
  }
  return "$longest $shortest";
}

bool containsDuplicates(List<int> list) {
  Set<int> uniqueElements = {};
  for (int element in list) {
    if (uniqueElements.contains(element)) {
      return true;
    }
    uniqueElements.add(element);
  }
  return false;
}

Set<String> uniqueCharacters1(String sentence) {
  Set<String> uniqueCharacters = {};
  for (var character in sentence.runes) {
    String temp = String.fromCharCodes([character]);
    if (uniqueCharacters.contains(temp)) {
      continue;
    }
    uniqueCharacters.add(temp);
  }
  return uniqueCharacters;
}

Set<String> uniqueCharacters2(String sentence) {
  return sentence.runes.map((rune) => String.fromCharCode(rune)).toSet();
}

Set<int> symmetricDifference1(Set<int> set1, Set<int> set2) {
  Set<int> symmetricDifference = {};
  for (int element in set1) {
    if (!set2.contains(element)) {
      symmetricDifference.add(element);
    }
  }
  for (int element in set2) {
    if (!set1.contains(element)) {
      symmetricDifference.add(element);
    }
  }
  return symmetricDifference;
}

Set<int> symmetricDifference2(Set<int> set1, Set<int> set2) {
  return set1.difference(set2).union(set2.difference(set1));
}

@JsonSerializable()
class User {
  final int id;
  final String name;
  final List<String> emails;

  const User({
    required this.id,
    required this.name,
    required this.emails,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  // Map<String, dynamic> toMap() {
  //   return {'id': id, 'name': name, 'emails': emails};
  // }

  // String toJson() => json.encode(toMap());

  // Map<String, dynamic> fromJson(String jsonStr) => json.decode(jsonStr);

  // factory User.fromMap(Map<String, dynamic> map) {
  //   return User(
  //     id: map['id'] as int,
  //     name: map['name'] as String,
  //     emails: List<String>.from(map['emails'] as List<dynamic>),
  //   );
  // }

  @override
  String toString() {
    return 'User(id: $id, name: $name, emails: $emails)';
  }
}

Map<String, int> characterFrequency1(String paragraph) {
  Map<String, int> frequency = {};
  for (var character in paragraph.runes) {
    String temp = String.fromCharCode(character);
    if (frequency.containsKey(temp)) {
      frequency[temp] = frequency[temp]! + 1;
    } else {
      frequency[temp] = 1;
    }
  }
  return frequency;
}

Map<String, int> characterFrequency2(String paragraph) {
  Map<String, int> frequency = {};
  for (var character in paragraph.characters) {
    if (frequency.containsKey(character)) {
      frequency[character] = frequency[character]! + 1;
    } else {
      frequency[character] = 1;
    }
  }
  return frequency;
}

@JsonSerializable()
class Widget {
  final double width;
  final double height;

  Widget(this.width, this.height);

  @override
  String toString() {
    return 'Widget(width: $width, height: $height)';
  }

  Map<String, dynamic> toJson() => _$WidgetToJson(this);

  factory Widget.fromJson(Map<String, dynamic> json) => _$WidgetFromJson(json);
}

Iterable<int> squares(int n) sync* {
  print("Method Start");
  for (int i = 1; i <= n; i++) {
    yield i * i;
  }
  print("Method End");
}

class FibonacciIterator implements Iterator<int> {
  final int? n;
  int _current = 0;
  int _previous = 1;
  var _counter = 0;

  FibonacciIterator(this.n);

  @override
  int current() => _current;

  @override
  bool moveNext() {
    if (_counter > 0 && n != null && _counter >= n!) {
      return false;
    }
    int next = _previous + _current;
    _previous = _current;
    _current = next;
    _counter++;
    return true;
  }
}

class Fibonacci extends Iterable<int> {
  final int? n;
  const Fibonacci(this.n);

  @override
  Iterator<int> get iterator => FibonacciIterator(n);
}

void main(List<String> args) {
  // var radius = int.parse(stdin.readLineSync()!);
  // Sphere sphere = Sphere(radius: radius);
  // print(sphere.volume);
  // print(sphere.surfaceArea);

  // TempClass().myMethod();

  // exercise1();

  // print(generateRandom());

  // print(tempTest(236));
  // print(tempTest(-236));
  // print(tempTest(null));

  // Name name1 = Name(givenName: "John", surname: "Doe", surnameIsFirst: true);
  // print(name1);
  // Name name2 = Name(givenName: "John", surnameIsFirst: false);
  // print(name2);
  // Name name3 = Name(givenName: "John", surname: "Doe", surnameIsFirst: false);
  // print(name3);
  // Name name4 = Name(givenName: "John");
  // print(name4);

  // final num = int.parse(stdin.readLineSync()!);
  // List<int> list = [];
  // for (int i = 0; i < num; i++) {
  //   list.add(int.parse(stdin.readLineSync()!));
  // }
  // print(filterEven(list));

  // List<String> days = [
  //   "Sunday",
  //   "Monday",
  //   "Tuesday",
  //   "Wednesday",
  //   "Thursday",
  //   "Friday",
  //   "Saturday"
  // ];
  // print(filterDays(days));

  // AppToDo app = AppToDo();
  // app.removeTask("Task 1");
  // app.viewTasks();
  // app.addTask(Task(name: "Task 1", description: "Description 1"));
  // app.addTask(Task(name: "Task 2", description: "Description 2"));
  // app.addTask(Task(name: "Task 3", description: "Description 3"));
  // app.viewTasks();
  // app.removeTask("Task 2");
  // app.viewTasks();
  // app.removeTask("Task 4");

  // const strings = ['cookies', 'ice cream', 'cake', 'donuts', 'pie', 'brownies'];
  // print(longestAndShortest(strings));

  // final myList = [1, 4, 2, 7, 3, 9];
  // print(containsDuplicates(myList));

  // const paragraphOfText = 'Once upon a time there was a Dart programmer who '
  //     'had a challenging challenge to solve. Though the challenge was great, '
  //     'a solution did come. The end.';
  // print(uniqueCharacters1(paragraphOfText));
  // print(uniqueCharacters2(paragraphOfText));

  // final setA = {8, 2, 3, 1, 4};
  // final setB = {1, 6, 5, 4};
  // print(symmetricDifference1(setA, setB));
  // print(symmetricDifference2(setA, setB));

  User user =
      User(id: 1, name: "John", emails: ["a@b.com", "c@d.com", "e@f.com"]);
  final userJson = user.toJson();
  print(userJson);
  final userFromJson = User.fromJson(userJson);
  print(userFromJson);

  // const paragraphOfText = 'Once upon a time there was a Dart programmer who '
  //     'had a challenging challenge to solve. Though the challenge was great, '
  //     'a solution did come. The end.';
  // print(characterFrequency1(paragraphOfText));
  // print(characterFrequency2(paragraphOfText));

  Widget widget = Widget(10, 20);
  final widgetJson = widget.toJson();
  print(widgetJson);
  final widgetFromJson = Widget.fromJson(widgetJson);
  print(widgetFromJson);

  // print("Start");
  // final square = squares(10);
  // print("Intermediate");
  // for (var i in square) {
  //   print(i);
  // }
  // print("End");

  List<int> myList = [1, 2, 3, 4];
  var iterator = myList.iterator;
  while (iterator.moveNext()) {
    print(iterator.current());
  }

  final fibonacciSeries = Fibonacci(10);
  for (int number in fibonacciSeries) {
    print(number);
  }
}

// Each type of collection has its strengths. Here’s some advice about when to use which:
// [] Choose lists if order matters. Try to insert values at the end of lists wherever possible to keep things running
// smoothly. And be aware that searching can be slow with large collections.​
// [] Choose sets if you’re only concerned with whether something is in the collection or not. This is faster than
// searching a list.​
// [] Choose maps if you frequently need to look up a value by its key. This is also a fast operation.​
// [] Choose iterables if you have large collections where you need to visit all the elements lazily.
