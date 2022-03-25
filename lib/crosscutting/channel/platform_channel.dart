import 'package:flutter/services.dart';

class PlatformChannel {
  static const platform = MethodChannel('com.bankfab.nhl');

  Future<bool> checkLiveness() async {
    try {
      final result = await platform.invokeMethod('LivenessCheck');
      print("Result is : $result");
      return result as bool;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<String> getTextFromImage() async {
    try {
      final result = await platform.invokeMethod('BlinkOCR');
      print("Result is : $result");
      return result as String;
    } on PlatformException catch (e) {
      print(e);
      return "";
    }
  }
}
