import 'package:flutter/services.dart';

class SelfShare {
  static const MethodChannel _channel = const MethodChannel('self_share');

  static shareInstagram(bool isVideo, bool isStory, String path, String clipboard) async {
    return await _channel.invokeMethod('shareInstagram', {
      "path": path,
      "isStory": isStory,
      "isVideo": isVideo,
      "clipboard": clipboard,
    });
  }

  static checkInstagram() async {
    return await _channel.invokeMethod('checkInstagram');
  }
}
