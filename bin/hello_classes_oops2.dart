import 'dart:math';
// import 'dart:io';

class BankAccount {
  String? _name;
  int? _balance;

  BankAccount({name, balance}) {
    _name = name;
    _balance = balance;
  }

  void display() {
    print("Name: $_name\nBalance: $_balance");
  }

  int? get balance => _balance;

  void deposit(int amount) {
    _balance = _balance! + amount;
    print("Deposited $amount");
  }

  void withdraw(int amount) {
    _balance = _balance! - amount;
    print("Withdrew $amount");
  }
}

class SavingsAccount extends BankAccount {
  SavingsAccount({name, balance}) : super(name: name, balance: balance);

  @override
  void withdraw(int amount) {
    if (amount > _balance!) {
      print("Insufficient balance");
    } else {
      super.withdraw(amount);
    }
  }
}

class Shape {
  double? _dim1;
  double? _dim2;
  double? _dim3;
  double? _dim4;
  double? _perimeter;

  Shape.rectangle({dim1, dim2}) {
    _dim1 = _dim2 = dim1;
    _dim3 = _dim4 = dim2;
    _perimeter = _dim1! + _dim2! + _dim3! + _dim4!;
  }

  Shape.square({dim1}) {
    _dim1 = _dim2 = _dim3 = _dim4 = dim1;
    _perimeter = _dim1! * 4;
  }

  Shape.circle({dim1}) {
    _dim1 = dim1;
    _dim2 = _dim3 = _dim4 = 0.0;
    _perimeter = _dim1! * pi;
  }

  Shape.triangle({dim1, dim2, dim3}) {
    _dim1 = dim1;
    _dim2 = dim2;
    _dim3 = dim3;
    _dim4 = 0.0;
    _perimeter = _dim1! + _dim2! + _dim3!;
  }

  double get perimeter => _perimeter!;
}

class Animal {
  String? _name;
  int? _age;
  int? _weight;
  String? _color;

  Animal({name, age, weight, color}) {
    _name = name;
    _age = age;
    _weight = weight;
    _color = color;
  }

  void display() {
    print("Name: $_name\nAge: $_age\nWeight: $_weight\nColor: $_color");
  }
}

class Cat extends Animal {
  String? _sound;

  Cat({name, age, weight, color, required sound})
      : super(name: name, age: age, weight: weight, color: color) {
    _sound = sound;
  }

  @override
  void display() {
    super.display();
    print("Sound: $_sound");
  }
}

class Dog extends Animal {
  String? _sound;

  Dog({name, age, weight, color, required sound})
      : super(name: name, age: age, weight: weight, color: color) {
    _sound = sound;
  }

  @override
  void display() {
    super.display();
    print("Sound: $_sound");
  }
}

class StringManipulations {
  StringManipulations();

  void splitString(String text) {
    List<String> lines = text.split("\n");
    print(lines);
  }

  void replaceEmoji() {
    const original = "How's the Dart book going? :]";
    final replaced = original.replaceAll(':]', '😊');
    print(replaced);
  }

  void buildStringPowerOfTwo() {
    final strB = StringBuffer();
    for (var i = 1; i <= 10; i++) {
      strB.write(pow(2, i));
      strB.write(' ');
    }
    print(strB.toString());
  }

  void buildPattern(int n) {
    final strB = StringBuffer();
    for (var i = 0; i < n; i++) {
      for (var j = 0; j < n; j++) {
        if (j == i) {
          strB.write('  ');
        } else {
          strB.write('* ');
        }
      }
      strB.write('\n');
    }
    print(strB.toString());
  }

  bool regexPasswordValidation(String str) {
    final regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{12,}$');
    return regex.hasMatch(str);
  }

  bool regexCreditCardValidation(String str) {
    final regex = RegExp(r'^[0-9]{16}$');
    return regex.hasMatch(str);
  }

  bool regexEmailValidation(String str) {
    final regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(str);
  }

  void findMultipleMatches(String str) {
    final strB = StringBuffer();
    final listOfHeaders = str.split('\n');
    for (var i = 0; i < listOfHeaders.length; i++) {
      final start = listOfHeaders[i].indexOf('<h1>') + "<h1>".length;
      final end = listOfHeaders[i].indexOf('</h1>');
      strB.write(listOfHeaders[i].substring(start, end));
      strB.write('\n');
    }
    print(strB.toString());
  }

  void extractTimeAndLyrics(String str) {
    final strB = StringBuffer();
    final timeStampLastIndex = str.indexOf(']');
    final lyrics = str.substring(timeStampLastIndex + 1);
    final timeStamp = str.substring(0, timeStampLastIndex + 1);
    strB.write(timeStamp);
    strB.write('\n');
    strB.write(lyrics);
    print(strB.toString());
  }

  // String Validation Packages
  // Although any serious developer should know how to use regular expressions, you also
  // don’t need to reinvent the wheel when it comes to string validation. Search pub.dev for
  // “string validation” to find packages that probably already do what you need. You can
  // always go to their source code and copy the regex pattern if you don’t want to add another
  // dependency just for a single validation.
}

int findElementsInEitherOrButNotBothSets(Set<int> a, Set<int> b) {
  int sum = 0;
  final result = a.union(b).difference(a.intersection(b));
  print(result);
  for (var element in result) {
    sum += element;
  }
  return sum;
}

String randomPasswordGenerator(int length) {
  if (length < 4) {
    throw ArgumentError(
        'The length should be at least 4 to include all required types.');
  }

  final random = Random();

  // Define character sets
  const uppercaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const lowercaseLetters = 'abcdefghijklmnopqrstuvwxyz';
  const numbers = '0123456789';
  const specialCharacters = '!@#\$%^&*()-_=+[]{}|;:<>,.?/';

  // Combine all sets
  final allCharacters =
      uppercaseLetters + lowercaseLetters + numbers + specialCharacters;

  // Create a StringBuffer and append a character from each required set
  final passwordBuffer = StringBuffer()
    ..write(uppercaseLetters[random.nextInt(uppercaseLetters.length)])
    ..write(lowercaseLetters[random.nextInt(lowercaseLetters.length)])
    ..write(numbers[random.nextInt(numbers.length)])
    ..write(specialCharacters[random.nextInt(specialCharacters.length)]);

  // Add remaining random characters to reach the specified length
  for (int i = 4; i < length; i++) {
    passwordBuffer.write(allCharacters[random.nextInt(allCharacters.length)]);
  }

  // Shuffle the characters
  var passwordChars = List<int>.from(passwordBuffer.toString().codeUnits)
    ..shuffle(random);

  return String.fromCharCodes(passwordChars);
}

abstract class Bottle {
  factory Bottle() => SodaBottle();
  void open();
}

class SodaBottle implements Bottle {
  @override
  void open() {
    print("Fizz Fizz");
  }
}

abstract class Database {
  List<String> getNotes();
  void addNote(String note);
  void deleteNote(String note);
  void updateNote(String oldNote, String newNote);
  factory Database() => MockDatabase();
}

class MockDatabase implements Database {
  List<String> notes = [
    "This is Note 1",
    "Buy Eggs, Milk & Bread",
    "This is Note 3",
    "Friend's family event",
  ];

  @override
  List<String> getNotes() {
    return notes;
  }

  @override
  void addNote(String note) {
    notes.add(note);
  }

  @override
  void deleteNote(String note) {
    notes.remove(note);
  }

  @override
  void updateNote(String oldNote, String newNote) {
    if (notes.contains(oldNote)) {
      int idx = notes.indexOf(oldNote);
      notes[idx] = newNote;
    } else {
      print("Note not found");
    }
  }
}

class Person {
  final String name;
  static final Map<String, Person> _cache = {};

  Person._internal(this.name);

  factory Person(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name]!;
    } else {
      final person = Person._internal(name);
      _cache[name] = person;
      return person;
    }
  }
}

class Singleton {
  static Singleton? _singleton = Singleton._internal();
  factory Singleton() {
    return _singleton ??= Singleton._internal();
  }
  Singleton._internal();
}

abstract class Product {
  factory Product(String type) {
    switch (type) {
      case 'A':
        return ProductA();
      case 'B':
        return ProductB();
      default:
        throw ArgumentError('Invalid product type: $type');
    }
  }
  void showInfo();
}

class ProductA implements Product {
  @override
  void showInfo() {
    print('Product A');
  }
}

class ProductB implements Product {
  @override
  void showInfo() {
    print('Product B');
  }
}

void main(List<String> args) {
  // SavingsAccount savingsAccount = SavingsAccount(
  //   name: "Siddhant",
  //   balance: 1000,
  // );
  // savingsAccount.display();
  // savingsAccount.deposit(500);
  // print("Balance: ${savingsAccount.balance}");
  // savingsAccount.deposit(200);
  // print("Balance: ${savingsAccount.balance}");
  // savingsAccount.withdraw(300);
  // print("Balance: ${savingsAccount.balance}");
  // savingsAccount.withdraw(4000);
  // print("Balance: ${savingsAccount.balance}");

  // Shape rectangle = Shape.rectangle(dim1: 10.0, dim2: 20.0);
  // print("Rectangle Perimeter: ${rectangle.perimeter}");
  // Shape square = Shape.square(dim1: 10.0);
  // print("Square Perimeter: ${square.perimeter}");
  // Shape circle = Shape.circle(dim1: 7.0);
  // print("Circle Perimeter: ${circle.perimeter}");
  // Shape triangle = Shape.triangle(dim1: 10.0, dim2: 20.0, dim3: 30.0);
  // print("Triangle Perimeter: ${triangle.perimeter}");

  // Animal cat =
  //     Cat(name: "Catters", age: 2, weight: 10, color: "Black", sound: "Meow");
  // cat.display();

  // print("");

  // Animal dog =
  //     Dog(name: "Doggers", age: 2, weight: 10, color: "Black", sound: "Woof");
  // dog.display();

  // StringManipulations sm = StringManipulations();
  // String test = "France\nUSA\nGermany\nBenin\nChina\nMexico\nMongolia";
  // sm.splitString(test);
  // sm.replaceEmoji();
  // sm.buildStringPowerOfTwo();
  // sm.buildPattern(10);
  // print(sm.regexPasswordValidation("Password1234"));
  // print(sm.regexPasswordValidation("password1234"));
  // print(sm.regexPasswordValidation("password"));
  // print(sm.regexPasswordValidation("P!@#as\$&swo*~rd1234"));
  // print(sm.regexCreditCardValidation('1111222233334444'));
  // print(sm.regexCreditCardValidation('123'));
  // print(sm.regexCreditCardValidation('aaaabbbbccccdddd'));
  // print(sm.regexCreditCardValidation('12341234123412345'));
  // const text =
  //     "<h1>Dart Tutorial</h1>\n<h1>Flutter Tutorial</h1>\n<h1>Java Tutorials</h1>\n<h1>Other Tutorials</h1>";
  // sm.findMultipleMatches(text);
  // print(sm.regexEmailValidation('me@example.com')); // true
  // print(sm.regexEmailValidation('my_email@example.com')); // true
  // print(sm.regexEmailValidation('my email@example.com')); // false
  // print(sm.regexEmailValidation('meexample.com')); // false
  // print(sm.regexEmailValidation('me@examplecom')); // false
  // const test = "[00:12.34]Row, row, row your boat";
  // sm.extractTimeAndLyrics(test);

  //   print(findElementsInEitherOrButNotBothSets({1, 3}, {3, 5}));
  //   print(randomPasswordGenerator(10));

  // final bottle = Bottle();
  // bottle.open();

  // final database = Database();
  // print(database.getNotes());
  // String newNote = "Water the flowers";
  // database.addNote(newNote);
  // print(database.getNotes());
  // String oldNote1 = "This is Note 1";
  // database.updateNote(oldNote1, newNote);
  // print(database.getNotes());
  // String oldNote2 = "This is Note 45";
  // database.updateNote(oldNote2, newNote);
  // print(database.getNotes());
  // database.deleteNote(newNote);
  // print(database.getNotes());

  // final person1 = Person("Person 1");
  // final person2 = Person("Person 2");
  // final person3 = Person("Person 1");
  // print("Person 1 Name: ${person1.name} with hashcode as ${person1.hashCode}");
  // print("Person 1 Name: ${person2.name} with hashcode as ${person2.hashCode}");
  // print("Person 1 Name: ${person3.name} with hashcode as ${person3.hashCode}");

  // Singleton singleton1 = Singleton();
  // Singleton singleton2 = Singleton();
  // print(singleton1 == singleton2);

  // Creating products using the factory method
  final productA = Product('A');
  final productB = Product('B');
  productA.showInfo(); // Output: Product A
  productB.showInfo(); // Output: Product B
}
