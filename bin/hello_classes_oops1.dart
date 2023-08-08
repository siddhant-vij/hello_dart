// import 'dart:io';

class Camera {
  String? name;
  String? color;
  int? megapixel;

  Camera(this.name, this.color, this.megapixel);
}

class SimpleInterest {
  double? principal;
  double? rate;
  double? time;

  SimpleInterest(this.principal, this.rate, this.time);

  double interest() {
    return (principal! * rate! * time!) / 100;
  }
}

class Car {
  String? name;
  String? color;
  int? price;

  Car({this.name, this.color, this.price});

  Car.named1({this.name, this.color, this.price = 0});

  void display() {
    print("Car Name: $name with $color color and $price price.");
  }
}

class Laptop {
  String? name;
  int? price;

  Laptop({this.name, this.price});

  Laptop.namedCheck({this.name, this.price = 50000});

  void display() {
    print("Price: Rs.$price");
  }
}

class MacBook extends Laptop {
  String? os;

  MacBook({name, this.os}) : super.namedCheck(name: name);

  @override
  void display() {
    print("Laptop Name: $name");
    super.display();
    print("Operating System: $os");
  }
}

class Rectangle {
  double? _width;
  double? _height;

  // Getters named width and height
  double get width => _width!;
  double get height => _height!;

  // Setters for these properties that ensure you can’t give negative values
  set width(double width) {
    if (width < 0) {
      _width = 0;
    } else {
      _width = width;
    }
  }

  set height(double height) {
    if (height < 0) {
      height = 0;
    } else {
      _height = height;
    }
  }

  // Getter for a calculated property named area that returns the area of the rectangle
  double get area => _width! * _height!;
}

class Student {
  final String firstName;
  final String lastName;
  int grade;
  Student(this.firstName, this.lastName, this.grade);
  @override
  String toString() {
    return 'Student: $firstName $lastName, Grade: $grade';
  }
}

// singleton class called TestSingleton
class TestSingleton {
  static TestSingleton? _instance;
  factory TestSingleton() {
    _instance ??= TestSingleton._internal();
    return _instance!;
  }
  TestSingleton._internal();
}

class Sphere {
  final int? _radius;
  static double pi = 3.14159265359;

  const Sphere({required int radius}) : _radius = radius;

  double get volume => 4 / 3 * pi * _radius! * _radius! * _radius!;
  double get surfaceArea => 4 * pi * _radius! * _radius!;
}

void main(List<String> args) {
  // String name = stdin.readLineSync()!;
  // String color = stdin.readLineSync()!;
  // int megapixel = int.parse(stdin.readLineSync()!);
  // Camera camera = Camera(name, color, megapixel);
  // print("Camera Name: ${camera.name} with ${camera.color} color and ${camera.megapixel} megapixel display!");

  // double principal = double.parse(stdin.readLineSync()!);
  // double rate = double.parse(stdin.readLineSync()!);
  // double time = double.parse(stdin.readLineSync()!);
  // SimpleInterest simpleInterest = SimpleInterest(principal, rate, time);
  // print("Simple Interest: ${simpleInterest.interest()}");

  // String name = stdin.readLineSync()!;
  // String color = stdin.readLineSync()!;
  // Car car1 = Car(name: name, color: color, price: 5000000);
  // car1.display();
  // Car car2 = Car.named1(name: name, color: color);
  // car2.display();

  // String name = stdin.readLineSync()!;
  // MacBook macBook = MacBook(name: name, os: "MacOS");
  // macBook.display();

  // Rectangle rectangle = Rectangle();
  // rectangle.width = 10.0;
  // rectangle.height = 20.0;
  // print(rectangle.area);

  // Student bert = Student("Bert", "Smith", 95);
  // print(bert);
  // Student ernie = Student("Ernie", "Walker", 85);
  // print(ernie);

  Sphere sphere = Sphere(radius: 12);
  print(sphere.volume);
  print(sphere.surfaceArea);
}
