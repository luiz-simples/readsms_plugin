import 'dart:async';
export 'model/sms.dart';
import 'package:flutter/services.dart';
import 'package:readsms/model/sms.dart';
export 'model/sms.dart';

class Readsms {
  static const _channel = EventChannel("readsms");
  final StreamController _controller = StreamController<SMS>();
  Stream<SMS> get smsStream => _controller.stream as Stream<SMS>;

  static StreamSubscription _channelStreamSubscription;

  read() {
    if (_channelStreamSubscription != null) _channelStreamSubscription.cancel();

    _channelStreamSubscription = _channel.receiveBroadcastStream().listen((e) {
      if (!_controller.isClosed) _controller.sink.add(SMS.fromList(e));
    });
  }

  void dispose() {
    _controller?.close();
    _channelStreamSubscription?.cancel();
  }
}
