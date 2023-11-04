// ------------- Futures & Order of Execution ------------
// Dart is single-threaded and handles asynchronous programming through concurrency rather than parallelism.
// Concurrency refers to rescheduling tasks to run later on the same thread, whereas parallelism refers to running tasks simultaneously on different threads.
// Dart uses an event loop to schedule asynchronous tasks.
// The event loop has an event queue and a microtask queue.
// A queue is a first-in-first-out (FIFO) data structure.
// Synchronous code always runs first and cannot be interrupted. After this comes anything in the microtask queue, and when these finish, any tasks in the event queue.
// You can run code in parallel by creating a new isolate.
// You can use delayed tasks to run code at a later time.

import 'dart:async';

class SynchronousHello {
  void printHello() {
    print("Hello-1");
    print("Hello-2");
    print("Hello-3");
  }
}

class EventQueueHello {
  void printHello() {
    print("Hello-1");
    Future(() => print("Hello-2-EQ"));
    print("Hello-3");
  }
}

class MicrotaskQueueHello {
  void printHello() {
    print("Hello-1");
    Future.microtask(() => print("Hello-2-MT"));
    print("Hello-3");
  }
}

class SynchronousEventQueueHello {
  void printHello() {
    print("Hello-1");
    Future(() => print("Hello-2-EQ-Sync"))
        .then((_) => print("Hello-3-EQ-Sync"));
    Future(() => print("Hello-4-EQ"));
    print("Hello-5");
  }
}

class DelayedEventQueueHello {
  void printHello() {
    print("Hello-1");
    Future.delayed(Duration(seconds: 2), () => print("Hello-2-Delayed"));
    print("Hello-3");
  }
}

class ChallengeOrder1 {
  void printInOrder() {
    print("1");
    Future(() => print("2")).then((value) => print(3));
    Future.microtask(() => print("4"));
    Future.microtask(() => print("5"));
    Future.delayed(Duration(seconds: 1), () => print("6"));
    Future(() => print("7")).then((value) => Future(() => print("8")));
    Future(() => print("9"))
        .then((value) => Future.microtask(() => print("10")));
    print("11");
  }
}

class ChallengeOrder2 {
  void printInOrder() {
    print("Start");
    Future(() => 1).then(print);
    Future(() => Future(() => 2)).then(print);
    Future.delayed(const Duration(seconds: 1), () => 3).then(print);
    Future.delayed(const Duration(seconds: 1), () => Future(() => 4))
        .then(print);
    Future.value(5).then(print);
    Future.value(Future(() => 6)).then(print);
    Future.sync(() => 7).then(print);
    Future.sync(() => Future(() => 8)).then(print);
    Future.microtask(() => 9).then(print);
    Future.microtask(() => Future(() => 10)).then(print);
    Future(() => 11).then(print);
    Future(() => Future(() => 12)).then(print);
    print("End");
  }
}

class ChallengeOrder3 {
  void printInOrder() {
    print("1");
    scheduleMicrotask(() => print("2"));
    Future.delayed(const Duration(seconds: 1), () => print("3"));
    Future(() => print("4")).then((_) => print("5")).then((_) {
      print("6");
      scheduleMicrotask(() => print("7"));
    }).then((_) => print("8"));
    scheduleMicrotask(() => print("9"));
    Future(() => print("10"))
        .then((_) => Future(() => print("11")))
        .then((_) => print("12"));
    Future(() => print("13"));
    scheduleMicrotask(() => print("14"));
    print("15");
  }
}

class ChallengeOrder4 {
  void printInOrder() {
    print("Start");
    print("1");
    scheduleMicrotask(() => print("2"));
    Future(() => 3).then(print);
    Future(() => Future(() => 4)).then(print);
    Future.delayed(const Duration(seconds: 1), () => 5).then(print);
    Future(() => 6).then((value) {
      print(value);
      return 7;
    }).then(print);
    Future.value(8).then(print);
    Future.value(Future(() => 9)).then(print);
    Future.sync(() => 10).then(print);
    scheduleMicrotask(() => Future(() => 11).then(print));
    print("End");
  }
}

class ChallengeOrder5 {
  void printInOrder() {
    print("1");
    Future(() => print("2"));
    scheduleMicrotask(() => print("3"));
    print("4");
  }
}

class ChallengeOrder6 {
  void printInOrder() {
    print("Start");
    Future(() => print("1")).then((_) => print("2"));
    Future.microtask(() => print("3")).then((_) => Future(() => print("4")));
    scheduleMicrotask(() => print("5"));
    print("End");
  }
}

class ChallengeOrder7 {
  void printInOrder() {
    print("Start");
    Future(() => print("1")).then((_) => Future(() => print("2")));
    Future.microtask(() => print("3"))
        .then((_) => Future.microtask(() => print("4")));
    Future.delayed(Duration(seconds: 1), () => print("5"));
    scheduleMicrotask(() => print("6"));
    print("End");
  }
}

class ChallengeOrder8 {
  void printInOrder() {
    print("Start");
    Future(() => print("1"))
        .then((_) => Future(() => print("2")))
        .then((_) => Future.microtask(() => print("3")));
    Future.microtask(() => print("4"))
        .then((_) => Future(() => print("5")))
        .then((_) => Future.delayed(Duration(seconds: 1), () => print("6")));
    scheduleMicrotask(() => print("7"));
    print("End");
  }
}

class ChallengeOrder9 {
  void printInOrder() {
    print("Start");
    Future(() => print("1"))
        .then((_) => Future(() => print("2")))
        .then((_) => Future.microtask(() => print("3")))
        .then((_) => Future(() => print("4")));
    Future.microtask(() => print("5"))
        .then((_) => Future(() => print("6")))
        .then((_) => Future.microtask(() => print("7")))
        .then((_) => Future(() => print("8")));
    Future.delayed(Duration(seconds: 1), () => print("9"));
    scheduleMicrotask(() => print("10"));
    print("End");
  }
}

class ChallengeOrder10 {
  void printInOrder() {
    print("Start");
    Future(() => print("1")).then((_) => print("2"));
    Future.microtask(() => print("3"));
    scheduleMicrotask(() => print("4"));
    Future.delayed(Duration(seconds: 1), () => print("5"));
    print("End");
  }
}

class ChallengeOrder11 {
  void printInOrder() {
    print("Start");
    Future(() => print("1")).then((_) => Future.microtask(() => print("2")));
    Future.microtask(() => print("3")).then((_) => Future(() => print("4")));
    scheduleMicrotask(() => print("5"));
    Future.delayed(Duration(seconds: 1), () => print("6"));
    print("End");
  }
}

class ChallengeOrder12 {
  void printInOrder() {
    print("Start");
    Future(() => print("1"))
        .then((_) => Future(() => print("2")))
        .then((_) => Future.microtask(() => print("3")));
    Future.microtask(() => print("4"))
        .then((_) => Future(() => print("5")))
        .then((_) => Future.microtask(() => print("6")));
    scheduleMicrotask(() => print("7"));
    Future.delayed(Duration(seconds: 1), () => print("8"));
    print("End");
  }
}

class ChallengeOrder13 {
  void printInOrder() {
    print("Start");
    Future(() => print("1"))
        .then((_) => Future(() => print("2")))
        .then((_) => Future.microtask(() => print("3")))
        .then((_) => Future(() => print("4")));
    Future.microtask(() => print("5"))
        .then((_) => Future(() => print("6")))
        .then((_) => Future.microtask(() => print("7")))
        .then((_) => Future(() => print("8")));
    scheduleMicrotask(() => print("9"));
    Future.delayed(Duration(seconds: 1), () => print("10"));
    print("End");
  }
}

class ChallengeOrder14 {
  void printInOrder() {
    print("Start");
    Future(() => print("1"))
        .then((_) => Future(() => print("2")))
        .then((_) => Future.microtask(() => print("3")))
        .then((_) => Future(() => print("4")));
    Future.microtask(() => print("5"))
        .then((_) => Future(() => print("6")))
        .then((_) => Future.microtask(() => print("7")))
        .then((_) => Future(() => print("8")));
    Future.delayed(Duration(seconds: 1), () => print("9"));
    scheduleMicrotask(() => print("10"));
    Future.sync(() => print("11")).then((_) => Future(() => print("12")));
    print("End");
  }
}

class ChallengeOrder15 {
  void printInOrder() {
    print("Start");
    Future(() => print("1")).then((_) => Future(() => print("2"))
        .then((_) => Future.microtask(() => print("3")))
        .then((_) => Future(() => print("4"))));
    Future.microtask(() => print("5")).then((_) => Future(() => print("6"))
        .then((_) => Future.microtask(() => print("7")))
        .then((_) => Future(() => print("8"))));
    scheduleMicrotask(() => print("9"));
    Future.delayed(Duration(seconds: 1), () => print("10")).then((_) =>
        Future(() => print("11"))
            .then((_) => Future.microtask(() => print("12"))));
    Future.sync(() => print("13")).then((_) => Future(() => print("14"))
        .then((_) => Future.microtask(() => print("15"))));
    print("End");
  }
}

void main(List<String> args) {
  // SynchronousHello().printHello();
  // EventQueueHello().printHello();
  // MicrotaskQueueHello().printHello();
  // SynchronousEventQueueHello().printHello();
  // DelayedEventQueueHello().printHello();
  // ChallengeOrder1().printInOrder();
  // ChallengeOrder2().printInOrder();
  // ChallengeOrder3().printInOrder();
  // ChallengeOrder4().printInOrder();
  // ChallengeOrder5().printInOrder();
  // ChallengeOrder6().printInOrder();
  // ChallengeOrder7().printInOrder();
  // ChallengeOrder8().printInOrder();
  // ChallengeOrder9().printInOrder();
  // ChallengeOrder10().printInOrder();
  // ChallengeOrder11().printInOrder();
  // ChallengeOrder12().printInOrder();
  // ChallengeOrder13().printInOrder();
  // ChallengeOrder14().printInOrder();
  ChallengeOrder15().printInOrder();
}
