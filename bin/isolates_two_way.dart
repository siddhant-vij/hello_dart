// Two-way communication can be set it up in a two-step process:
// - Create a receive port in the parent isolate and pass its send port to the child isolate. This allows the child to send messages to the parent.
// - Create a receive port in the child isolate and send that receive port’s send port back to the parent isolate. This allows the parent to send messages to the child.

import 'dart:io';
import 'dart:isolate';

class Work {
  Future<int> doSomeWork() async {
    print('Doing some work');
    sleep(const Duration(seconds: 2));
    return 42;
  }

  Future<int> doSomeMoreWork() async {
    print('Doing some more work');
    sleep(const Duration(seconds: 2));
    return 24;
  }
}

class Mars {
  Future<void> entryPoint(SendPort sendToEarthPort) async {
    final receiveOnMarsPort = ReceivePort();
    sendToEarthPort.send(receiveOnMarsPort.sendPort);
    final work = Work();
    receiveOnMarsPort.listen(
      (messageFromEarth) async {
        await Future.delayed(const Duration(seconds: 1));
        print('Message from Earth: $messageFromEarth');
        if (messageFromEarth == 'Hey from Earth!') {
          sendToEarthPort.send('Hey from Mars!');
        } else if (messageFromEarth == 'Can you help?') {
          sendToEarthPort.send('I can help!');
        } else if (messageFromEarth == 'doSomeWork') {
          final result = await work.doSomeWork();
          sendToEarthPort.send({
            'method': 'doSomeWork',
            'result': result,
          });
        } else if (messageFromEarth == 'doSomeMoreWork') {
          final result = await work.doSomeMoreWork();
          sendToEarthPort.send({
            'method': 'doSomeMoreWork',
            'result': result,
          });
          sendToEarthPort.send('Done!');
        }
      },
    );
  }
}

class Earth {
  final _receiveOnEarthPort = ReceivePort();
  SendPort? _sendToMarsPort;
  Isolate? _marsIsolate;

  Future<void> contactMars() async {
    if (_marsIsolate != null) {
      return;
    }
    _marsIsolate = await Isolate.spawn<SendPort>(
      Mars().entryPoint,
      _receiveOnEarthPort.sendPort,
    );
    _receiveOnEarthPort.listen(
      (messageFromMars) async {
        await Future.delayed(const Duration(seconds: 1));
        print('Message from Mars: $messageFromMars');
        if (messageFromMars is SendPort) {
          _sendToMarsPort = messageFromMars;
          _sendToMarsPort?.send('Hey from Earth!');
        } else if (messageFromMars == 'Hey from Mars!') {
          _sendToMarsPort?.send('Can you help?');
        } else if (messageFromMars == 'I can help!') {
          _sendToMarsPort?.send('doSomeWork');
          _sendToMarsPort?.send('doSomeMoreWork');
        } else if (messageFromMars is Map) {
          final method = messageFromMars['method'] as String;
          final result = messageFromMars['result'] as int;
          print('Method: $method, result: $result');
        } else if (messageFromMars == 'Done!') {
          print('Shutting down!');
          dispose();
        }
      },
    );
  }

  void dispose() {
    _receiveOnEarthPort.close();
    _marsIsolate?.kill();
    _marsIsolate = null;
  }
}

Future<void> main() async {
  final earth = Earth();
  await earth.contactMars();
}
