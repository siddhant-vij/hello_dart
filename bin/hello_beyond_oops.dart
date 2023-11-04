// Dart - Beyond OOPS

// 1. Mixins
// Mixins allow you to share code between classes.
// You can use any class as a mixin as long as it doesn’t extend anything besides Object .
// Using the mixin keyword means that a class can only be used as a mixin.

// 2. Extensions
// Extension methods allow you to give additional functionality to classes that are not your own.
// Use extensions when they make sense, but try not to overuse them.

// 3. Generics
// Generics allow classes and functions to accept data of any type.
// The angle brackets surrounding a type tell the class or function the data type it will use.
// Use the letter T as a generic symbol for any single type.
// Use the letter E to refer to the element type in a generic collection.
// You can restrict the range of allowable types by using the extends keyword within the angle brackets.

// 4. Enhanced Enums
// Dart enums are subclasses of Enum.
// Enums are good for representing a fixed number of options.
// Prefer enums over strings or integers as option markers.
// Enhanced enums support constructors, properties, methods, operator overloading, interfaces, mixins and generics.
// Enums must have const constructors.
// The enum values are instances of the enum class.

// 5. Operator Overloading
// Operator overloading allows classes to give their own definitions to some operators.

abstract class Bird {
  void fly();
  void laysEggs();
}

abstract class Animal {
  void eat();
  void move();
}

mixin Flyer {
  void fly() {
    print("Fly... Fly...");
  }
}

mixin EggsLayer {
  void laysEggs() {
    print("Eggs... Eggs...");
  }
}

class Robin extends Bird with Flyer, EggsLayer {}

class Platypus extends Animal with EggsLayer implements Comparable<Platypus> {
  final double weight;
  final String name;

  Platypus({this.name = "default", required this.weight});

  @override
  void eat() {
    print("Eat... Eat...");
  }

  @override
  void move() {
    print("Move... Move...");
  }

  @override
  int compareTo(Platypus other) {
    return weight.compareTo(other.weight);
  }
}

extension on String {
  String get encoded => _code(1);
  String get decoded => _code(-1);

  String _code(int step) {
    final output = StringBuffer();
    for (final codePoint in runes) {
      output.writeCharCode(codePoint + step);
    }
    return output.toString();
  }
}

extension on List<int> {
  int sum() => reduce((sum, element) => sum + element);
}

extension on int {
  Duration get minutes => Duration(minutes: this);
}

// class Tree Node for a Binary Tree - Generics
class Node<T> {
  final T? value;
  Node<T>? left;
  Node<T>? right;
  Node(this.value);
}

// createTree method using Generics to create a binary tree
Node<E>? createTree<E>(List<E> nodes, [int index = 0]) {
  if (index >= nodes.length) {
    return null;
  }
  final node = Node<E>(nodes[index]);
  node.left = createTree(nodes, 2 * index + 1);
  node.right = createTree(nodes, 2 * index + 2);
  return node;
}

// Implement Stack Data Structure with methods push, pop, peek, isEmpty, and toString - using Generics.
class Stack<E> {
  final List<E>? _stack;
  int _size;

  Stack()
      : _stack = [],
        _size = 0;

  void push(E value) {
    _stack!.add(value);
    _size++;
  }

  E pop() {
    _size--;
    return _stack!.removeLast();
  }

  E peek() {
    return _stack!.last;
  }

  bool isEmpty() {
    return _size == 0;
  }

  int get size => _size;

  @override
  String toString() {
    return _stack.toString();
  }
}

class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);

  @override
  String toString() {
    return "($x, $y)";
  }

  @override
  bool operator ==(Object other) {
    return other is Point && other.x == x && other.y == y;
  }

  Point operator +(Point other) {
    return Point(x + other.x, y + other.y);
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

enum TrafficLight {
  red("Stop!"),
  yellow("Slow Down!"),
  green("Go!");

  final String message;
  const TrafficLight(this.message);
}

abstract class Serializable {
  String serialize();
  Day deserialize(String str);
}

enum Day implements Serializable {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  Day operator +(int daysToAdd) {
    return Day.values[(index + daysToAdd) % 7];
  }

  Day operator -(int daysToSubtract) {
    return Day.values[(index - daysToSubtract) % 7];
  }

  Day get next {
    return Day.values[(index + 1) % 7];
  }

  @override
  String serialize() => name[0].toUpperCase() + name.substring(1).toLowerCase();

  @override
  Day deserialize(String str) {
    return Day.values
        .firstWhere((element) => element.name == str, orElse: () => Day.monday);
  }
}

enum HttpResponseStatusCodes {
  ok(200, "OK"),
  created(201, "Created"),
  badRequest(400, "Bad Request"),
  unauthorized(401, "Unauthorized"),
  forbidden(403, "Forbidden"),
  notFound(404, "Not Found"),
  internalServerError(500, "Internal Server Error");

  final int statusCode;
  final String meaning;
  const HttpResponseStatusCodes(this.statusCode, this.meaning);

  @override
  String toString() {
    return "$statusCode - $meaning";
  }
}

void main(List<String> args) {
  Platypus platypus = Platypus(weight: 1.0);
  platypus.eat();
  platypus.move();
  platypus.laysEggs();
  Robin robin = Robin();
  robin.fly();
  robin.laysEggs();

  final willi = Platypus(name: "willi", weight: 1.0);
  final billi = Platypus(name: "billi", weight: 2.4);
  final nilli = Platypus(name: "nilli", weight: 2.1);
  final jilli = Platypus(name: "jilli", weight: 0.4);
  final silli = Platypus(name: "silli", weight: 1.7);
  final platypi = [willi, billi, nilli, jilli, silli];
  platypi.sort();
  for (var platypus in platypi) {
    print(platypus.name);
  }

  final original = "Dart is awesome!";
  final encoded = original.encoded;
  final decoded = encoded.decoded;
  print(encoded);
  print(decoded);

  List<int> myList = [1, 2, 3, 4];
  print(myList.sum()); // error if called on List<String>

  final time = 10.minutes;
  print(time);

  final intTree = createTree([1, 2, 3, 4, 5, 6, 7]);
  print(intTree.runtimeType);
  final stringTree = createTree(["A", "B", "C", "D", "E", "F", "G"]);
  print(stringTree.runtimeType);

  final intStack = Stack<int>();
  intStack.push(9);
  intStack.push(2);
  intStack.push(5);
  intStack.push(3);
  print(intStack.pop());
  print(intStack.peek());
  print(intStack.isEmpty());
  print(intStack);

  final stringStack = Stack<String>();
  stringStack.push('nine');
  stringStack.push('two');
  stringStack.push('five');
  stringStack.push('three');
  print(stringStack.pop());
  print(stringStack.peek());
  print(stringStack.isEmpty());
  print(stringStack);

  const pointA = Point(1, 4);
  const pointB = Point(3, 2);
  print(pointA == pointB);
  print(pointA + pointB);

  final trafficLight = TrafficLight.green;
  print(trafficLight.message);

  var day = Day.monday;
  day = day + 2;
  print(day.name);
  day += 4;
  print(day.name);
  day++;
  print(day.name);
  final restDay = Day.saturday;
  print(restDay.next.name);

  final dayTest = Day.monday;
  final serialized = dayTest.serialize();
  print(serialized);
  final deserialized = dayTest.deserialize(serialized);
  print(deserialized);

  print("");

  final dayMinus = Day.monday - 2;
  print(dayMinus.serialize());
  final dayPlus = Day.monday + 2;
  print(dayPlus.serialize());

  print("");

  final http = HttpResponseStatusCodes.internalServerError;
  print(http);

  print("");

  int? val1 = 1;
  int? val2;
  int? val3 = 3;
  int? val4;
  print(add(val1, val2));
  print(add(val2, val3));
  print(add(val2, val4));
  print(add(val1, val3));

  print("");

  final map1 = {"a": 1, "b": 2};
  final map2 = {"c": 3, "d": 4, "a": 1};
  print(map1 + map2);
  print(map1 - map2);
  print(map1 * 2);
  print(map2 * 3);

  print("");

  final tkey1 = "name";
  final tkey2 = "age";
  final tmap = {"name": "Test", "age": 21};
  final doubleAge = tmap.applyFunction(tkey2, (int value) => value * 2);
  print(doubleAge);
  final ageAsString = tmap.applyFunction(tkey2, (int value) => value.toString());
  print(ageAsString);
  final capitalName = tmap.applyFunction(tkey1, (String value) => value.toUpperCase());
  print(capitalName);
}

int add(int? a, int? b) {
  return a + b;
}

extension AddOptionals<T extends num> on T? {
  T operator +(T? other) {
    final shadow = this;
    if (shadow != null && other == null) {
      return shadow;
    } else if (shadow == null && other != null) {
      return other;
    } else if (shadow != null && other != null) {
      return shadow + other as T;
    } else {
      return 0 as T;
    }
  }
}

extension MapOperations<K, V> on Map<K, V> {
  Map<K, V> operator +(Map<K, V> other) {
    final result = <K, V>{}
      ..addAll(this)
      ..addAll(other);
    return result;
  }

  Map<K, V> operator -(Map<K, V> other) {
    final result = <K, V>{};
    result.addAll(this);
    result.removeWhere((key, value) => other.containsKey(key));
    return result;
  }

  Iterable<Map<K, V>> operator *(int times) sync* {
    for (var i = 0; i < times; i++) {
      yield this;
    }
  }
}

extension ApplyFunction<K, V, R> on Map<K, V> {
  R? applyFunction<T>(K key, R? Function(T value) func) {
    final value = this[key];
    if (value != null) {
      return func(value as T);
    } else {
      return null;
    }
  }
}
