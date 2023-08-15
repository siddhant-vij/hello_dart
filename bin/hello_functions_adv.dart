// In Dart, functions are first-class citizens. This means that you can treat a function as a value of other types. So you can:
// - Assign a function to a variable
// - Pass a function as an argument
// - Return a function

// An anonymous function is a function that does not have a name.
// If you remove the return type and name from a named function, you’ll have an anonymous function.
// Typically, you assign an anonymous function to a variable and use the variable to call the function.
// In practice, you often pass an anonymous function to another function that accepts a function as an argument.
// You could also define an anonymous function that returns another anonymous function.

// if an anonymous function has one line, you can convert it to an arrow function to make it more compact:
// (parameters) => expression;
// Anonymous functions & closures(surrounding scope), callback functions(handling events), tear-offs(.func() or .func.call()).

// Higher‐Order Functions With Collections
// Functions that return functions or accept them as parameters: map-filter-reduce.
// forEach performs a task on each collection element but doesn’t return any values.
// Mapping is where you transform every value into a new one. One example would be squaring each value.
// Filtering allows you to remove elements from a collection, such as by filtering out all the even numbers.
// Reducing consolidates a collection to a single value, such as by summing the elements.

int add(int a, int b) {
  return a + b;
}

int subtract(int a, int b) {
  return a - b;
}

Function calculation(String op) {
  switch (op) {
    case '+':
      return add;
    case '-':
      return subtract;
    default:
      return add;
  }
}

bool isEven(int n) {
  return n % 2 == 0;
}

bool isOdd(int n) {
  return n % 2 != 0;
}

void show(Function fn) {
  for (var i = 0; i < 4; i++) {
    if (fn(i)) {
      print(i);
    }
  }
}

void main(List<String> args) {
  var fn = add; // Assigning a function to a variable
  print(fn(1, 2));

  print("");

  print("Even Numbers: ");
  show(isEven); // Pass a function as an argument
  print("Odd Numbers: ");
  // Pass anonymous function as an argument
  show((int x) {
    return x % 2 != 0;
  });

  print("");

  var fn2 = calculation('+'); // Return a function
  print(fn2(1, 2));
  var fn3 = calculation('-');
  print(fn3(1, 2));

  print("");

  // Assign an anonymous function to a variable
  // var product = (int a, int b) {
  //   return a * b;
  // };

  // Issue: Use a function declaration rather than a variable assignment to bind a function to a name. Try rewriting the closure assignment as a function declaration.
  product(int a, int b) {
    return a * b;
  }

  print(product(1, 2));

  print("");

  // Define an anonymous function that returns another anonymous function
  // var division = (int x) {
  //   return (int y) {
  //     return y / x;
  //   };
  // };

  // Use a function declaration rather than a variable assignment to bind a function to a name. Try rewriting the closure assignment as a function declaration.
  division(int x) {
    return (int y) {
      return y / x;
    };
  }

  var halfIt = division(2);
  print(halfIt(10));

  print("");

  final list1 = [1, 2, 3, 4, 5];
  final newList1 = list1
      .map((x) => x * x)
      .toList(); // Without toList(), map() produces an Iterable.
  // Anonymous function passed as argument to higher-order map() function to square each element of the list
  print(newList1);

  print("");

  final list2 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  final newList2 = list2.where((x) => x % 2 == 0).toList();
  // Anonymous function passed as argument to higher-order where() - filter function to get only even numbers
  print(newList2);

  print("");

  final list3 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  final sum1 = list3.reduce((x, y) => x + y);
  // Anonymous function passed as argument to higher-order reduce() function to get the sum of the list
  final sum2 = list3.fold(0, (x, y) => x + y);
  // Anonymous function passed as argument to higher-order fold() function to get the sum of the list
  print(sum1);
  print(sum2);

  // Why would you use fold() instead of reduce()?
  // Because calling reduce on an empty list gives an error, using fold will be more reliable when a collection has a possibility of containing zero elements. The fold method works like reduce, but it takes an extra parameter that provides a starting value for the function.

  print("");

  // Anonymous function passed as argument to higher-order forEach() function to double each element of the list
  // final list4 = [1, 2, 3];
  // list4.forEach((int x) {
  //   print(x * 2);
  // });

  // Issue: Function literals shouldn't be passed to 'forEach'. Try using a 'for' or for-in loop.
  // final list4 = [1, 2, 3];
  // for (var x in list4) {
  //   print(x * 2);
  // }

  // or assign your function to a variable, using a function declaration.
  final list4 = [1, 2, 3];
  func(int x) => print(x * 2);
  list4.forEach(func);

  print("");

  // Iterating Over a Map: Map collections are not iterable, so they don’t directly support for-in loops.
  // However, they do have a forEach method.
  final flowerColor = {
    'roses': 'red',
    'violets': 'blue',
  };
  flowerColor.forEach((key, value) {
    print('$key are $value');
  });

  print("");

  // Custom Sort in a list of strings using sort() based on the number of vowels in them
  final names = [
    "brownies3",
    "cookies4",
    "donuts2",
    "pie2",
    "ice cream4",
    "cake2",
    "tart1"
  ];
  names.sort((a, b) {
    int aCount = 0;
    int bCount = 0;
    for (var i = 0; i < a.length; i++) {
      if (a[i] == 'a' ||
          a[i] == 'e' ||
          a[i] == 'i' ||
          a[i] == 'o' ||
          a[i] == 'u') {
        aCount++;
      }
    }
    for (var i = 0; i < b.length; i++) {
      if (b[i] == 'a' ||
          b[i] == 'e' ||
          b[i] == 'i' ||
          b[i] == 'o' ||
          b[i] == 'u') {
        bCount++;
      }
    }
    return aCount - bCount;
  });
  print(names);

  print("");

  // Combining Higher‐Order Methods
  // Take only the desserts that have a name length greater than 5 and then convert those names to uppercase
  final desserts = ['cake', 'pie', 'donuts', 'brownies'];
  final result =
      desserts.where((x) => x.length > 5).map((x) => x.toUpperCase()).toList();
  print(result);

  print("");

  final scores = [89, 77, 46, 93, 82, 67, 32, 88];
  // sort from highest to lowest
  scores.sort((a, b) => b.compareTo(a));
  print(scores);
  // find all the B grades, that is, all the scores between 80 and 90
  print(scores.where((x) => x >= 80 && x < 90).toList());

  print("");

  final button = Button(
      text: 'Click Me',
      onClick: () {
        print('Clicked!');
      });
  button.onClick.call();

  print("");

  final surface = Surface(onTouch: (x, y) => print('$x, $y'));
  surface.touch(202.3, 134.0);

  print("");

  final animals = {
    'sheep': 99,
    'goats': 32,
    'snakes': 7,
    'lions': 80,
    'seals': 18,
  };
  final totalStartsWithS = animals.entries
      .where((entry) => entry.key.startsWith('s'))
      .fold(0, (sum, entry) => sum + entry.value);
  print(totalStartsWithS);

  print("");

  print(repeatTask(4, 2, (x) => x * x));
}

int repeatTask(int times, int input, Function task) {
  for (var i = 0; i < times; i++) {
    input = task(input);
  }
  return input;
}

class Button {
  final String text;
  final void Function() onClick;
  Button({required this.text, required this.onClick});
}

typedef TouchHandler = void Function(double x, double y);

class Surface {
  final TouchHandler onTouch;
  Surface({required this.onTouch});

  void touch(double x, double y) => onTouch(x, y);
}
