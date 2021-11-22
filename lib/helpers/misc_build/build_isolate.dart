import 'dart:async';
import 'dart:isolate';

import 'package:helpers/helpers/print.dart';

typedef IsolateDataRecived<T> = FutureOr Function(T data, SendPort sendPort);

class _BuildIsolateMessageArguments<T> {
  _BuildIsolateMessageArguments({
    required this.mainSendPort,
    required this.onDataRecived,
    required this.queueMode,
  });

  final SendPort mainSendPort;
  final IsolateDataRecived<T> onDataRecived;
  final bool queueMode;
}

class BuildIsolate<T> {
  final Completer<SendPort> _completer = Completer<SendPort>();
  late Isolate _isolate;
  late SendPort _isolateSendPort;
  late StreamSubscription _mainListenSubscription;
  late ReceivePort _mainReceivePort;

  bool get isInitialized => _completer.isCompleted;

  Future<SendPort> init({
    required IsolateDataRecived<T> onDataRecived,
    required IsolateDataRecived<T> onIsolateDataRecived,
    Object? initialMessage,
    bool queueMode = false,
  }) async {
    _mainReceivePort = ReceivePort();
    _isolate = await Isolate.spawn(
      _isolateEntryPoint,
      _BuildIsolateMessageArguments<T>(
        mainSendPort: _mainReceivePort.sendPort,
        onDataRecived: onIsolateDataRecived,
        queueMode: queueMode,
      ),
    );
    _mainListenSubscription = _mainReceivePort.listen((data) async {
      if (data is SendPort) {
        _isolateSendPort = data;
        _completer.complete(_isolateSendPort);
        if (initialMessage != null) _isolateSendPort.send(initialMessage);
      } else if (data is T) {
        final future = onDataRecived(data, _isolateSendPort);
        if (queueMode) await future;
      }
    });
    return _completer.future;
  }

  static Future<void> _isolateEntryPoint<T>(
    _BuildIsolateMessageArguments<T> params,
  ) async {
    final ReceivePort isolateReceiverPort = ReceivePort();
    params.mainSendPort.send(isolateReceiverPort.sendPort);
    await for (final data in isolateReceiverPort) {
      if (data is T) {
        final handlerFuture = params.onDataRecived(data, params.mainSendPort);
        if (params.queueMode) await handlerFuture;
      }
    }
  }

  /// Sends an asynchronous [message] through this send port, to its
  /// corresponding `ReceivePort`.
  ///
  /// The content of [message] can be:
  ///   - [Null]
  ///   - [bool]
  ///   - [int]
  ///   - [double]
  ///   - [String]
  ///   - [List] or [Map] (whose elements are any of these)
  ///   - [TransferableTypedData]
  ///   - [SendPort]
  ///   - [Capability]
  ///
  /// In the special circumstances when two isolates share the same code and are
  /// running in the same process (e.g. isolates created via [Isolate.spawn]),
  /// it is also possible to send object instances (which would be copied in the
  /// process). This is currently only supported by the
  /// [Dart Native](https://dart.dev/platforms#dart-native-vm-jit-and-aot)
  /// platform.
  ///
  /// The send happens immediately and doesn't block.  The corresponding receive
  /// port can receive the message as soon as its isolate's event loop is ready
  /// to deliver it, independently of what the sending isolate is doing.
  void sendMessage(Object? message) {
    assert(isInitialized);
    _isolateSendPort.send(message);
  }

  /// Requests the isolate to shut down.
  ///
  /// The isolate is requested to terminate itself.
  /// The [priority] argument specifies when this must happen.
  ///
  /// The [priority], when provided, must be one of [immediate] or
  /// [beforeNextEvent] (the default).
  /// The shutdown is performed at different times depending on the priority:
  ///
  /// * `immediate`: The isolate shuts down as soon as possible.
  ///     Control messages are handled in order, so all previously sent control
  ///     events from this isolate will all have been processed.
  ///     The shutdown should happen no later than if sent with
  ///     `beforeNextEvent`.
  ///     It may happen earlier if the system has a way to shut down cleanly
  ///     at an earlier time, even during the execution of another event.
  /// * `beforeNextEvent`: The shutdown is scheduled for the next time
  ///     control returns to the event loop of the receiving isolate,
  ///     after the current event, and any already scheduled control events,
  ///     are completed.
  ///
  /// If [terminateCapability] is `null`, or it's not the terminate capability
  /// of the isolate identified by [controlPort],
  /// the kill request is ignored by the receiving isolate.
  void dispose({int priority = Isolate.immediate}) {
    _mainListenSubscription.cancel();
    _mainReceivePort.close();
    _isolate.kill(priority: priority);
  }

  static Future<T> single<T>(
    Object? intialValue,
    Future<T> Function(Object? data) test,
  ) async {
    final BuildIsolate isolate = BuildIsolate();
    final Completer<T> completer = Completer<T>();
    await isolate.init(
      onIsolateDataRecived: (data, sendPort) async {
        printAmber("$data", prefix: "isolate");
        // sendPort.send(await test(data));
      },
      onDataRecived: (data, sendPort) {
        printAmber("$data", prefix: "main");
        // if (data is T) completer.complete(data);
      },
    );
    completer.future.then((value) => isolate.dispose());
    return completer.future;
  }
}
