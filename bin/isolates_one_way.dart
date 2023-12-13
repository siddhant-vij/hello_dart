// Before you spawn a new isolate, you first create a ReceivePort object. Then, when you spawn the isolate, you pass it a reference to the SendPort property of your receive port. That way, the new isolate can send messages over the send port back to the main isolate’s receive port.

import 'dart:io';
import 'dart:isolate';

void longComputation(List<Object> args) {
  final sendPort = args[0] as SendPort;
  final sumTo = args[1] as int;
  var sum = 0;
  for (var i = 1; i <= sumTo; i++) {
    sum += i;
    sleep(const Duration(microseconds: 100));
  }
  final message1 = "Sum of 1 to $sumTo is $sum";
  sendPort.send(message1);
  sendPort.send(null);
}

Future<void> main() async {
  final receivePort = ReceivePort();
  final isolate = await Isolate.spawn<List<Object>>(
    longComputation,
    [
      receivePort.sendPort,
      1000000,
    ],
  );
  receivePort.listen(
    (message) {
      if (message == null) {
        print("Done");
        receivePort.close();
        isolate.kill();
      } else {
        print(message);
      }
    },
  );
}
