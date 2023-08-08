// import 'dart:io';
import 'dart:math';

enum AudioState { playing, paused, stopped }

void main(List<String> args) {
  // print(stdin.readLineSync().toString());
  // print(removeWhiteSpaces(stdin.readLineSync().toString()));
  // print('');
  // print(calculator(int.parse(stdin.readLineSync()!),
  //     int.parse(stdin.readLineSync()!), stdin.readLineSync().toString()));
  // print('');
  // var (result, operator) = calculatorRecord(int.parse(stdin.readLineSync()!),
  //     int.parse(stdin.readLineSync()!), stdin.readLineSync().toString());
  // print("$result $operator");
  // print("");
  // print(reverseString(stdin.readLineSync().toString()));

  // const audioState = AudioState.playing;
  // switch (audioState) {
  //   case AudioState.playing:
  //     print("Playing");
  //     break;
  //   case AudioState.paused:
  //     print("Paused");
  //     break;
  //   case AudioState.stopped:
  //     print("Stopped");
  //     break;
  //   default:
  //     print("Unknown");
  //     break;
  // }

  // print(nextPowerOfTwo(int.parse(stdin.readLineSync()!)));

  // print(nFib(int.parse(stdin.readLineSync()!)));

  // print(areaOfCircle(double.parse(stdin.readLineSync()!)));

  // print(isPrime(int.parse(stdin.readLineSync()!)));

  print(greeting());
}

String greeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return "Good Morning";
  } else if (hour < 18) {
    return "Good Afternoon";
  } else {
    return "Good Evening";
  }
}

void printEvenNumbers(int start, int end) {
  for (var i = start; i <= end; i++) {
    if (i % 2 == 0) {
      print(i);
    }
  }
}

bool isPrime(int n) {
  if (n == 1) {
    return false;
  }
  for (var i = 2; i * i <= n; i++) {
    if (n % i == 0) {
      return false;
    }
  }
  return true;
}

double areaOfCircle(double radius) {
  return pi * pow(radius, 2);
}

int nFib(int n) {
  if (n == 0 || n == 1) {
    return n;
  }
  return nFib(n - 1) + nFib(n - 2);
}

int nextPowerOfTwo(int n) {
  int result = 1;
  while (result < n) {
    result <<= 1;
  }
  return result;
}

String reverseString(String str) {
  return str.split('').reversed.join('');
}

(int, String) calculatorRecord(int a, int b, String op) {
  if (op == '+') {
    return (a + b, op);
  } else if (op == '-') {
    return (a - b, op);
  } else if (op == '*') {
    return (a * b, op);
  } else if (op == '/') {
    return (a ~/ b, op);
  } else {
    return (-1 >>> 1, op);
  }
}

int calculator(int a, int b, String op) {
  if (op == '+') {
    return a + b;
  } else if (op == '-') {
    return a - b;
  } else if (op == '*') {
    return a * b;
  } else if (op == '/') {
    return a ~/ b;
  } else {
    return -1 >>> 1;
  }
}

String removeWhiteSpaces(String x) {
  String str = x.trim();
  String result = "";
  for (var i = 0; i < str.length; i++) {
    if (str[i] != ' ') {
      result += str[i];
    }
  }
  return result;
}
