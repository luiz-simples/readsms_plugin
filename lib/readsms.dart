import 'dart:async';
export 'model/sms.dart';
import 'package:flutter/services.dart';
import 'package:readsms/model/sms.dart';
export 'model/sms.dart';

class Readsms {
  static const _channel = EventChannel("readsms");
  static StreamController _controller;
  Stream<SMS> get smsStream => _controller.stream as Stream<SMS>;

  static StreamSubscription _channelStreamSubscription;

  read() {
    if (_controller != null) _controller.close();
    if (_channelStreamSubscription != null) _channelStreamSubscription.cancel();

    _controller = StreamController<SMS>();
    _channelStreamSubscription = _channel.receiveBroadcastStream().listen((e) {
      if (!_controller.isClosed) _controller.sink.add(SMS.fromList(e));
    });
  }

  void dispose() {
    _controller?.close();
    _channelStreamSubscription?.cancel();
    _controller = null;
    _channelStreamSubscription = null;
  }
}
