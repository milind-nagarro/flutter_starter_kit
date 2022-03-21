import 'package:flutter/services.dart';

class FaceTec {
  static const platform = MethodChannel('com.example.facetec.poc');

  // Future<void> livenessCheck() async {
  //   try {
  //     platform.invokeMethod('LivenessCheck').then((value) {
  //       print(value);
  //     });
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  // }
  //
  // Future<void> enrollUser() async {
  //   try {
  //     platform.invokeMethod('EnrollUser').then((value) {
  //       print(value);
  //     });
  //
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  // }
  //
  // Future<void> authenticateUser() async {
  //   try {
  //     platform.invokeMethod('AuthenticateUser').then((value) {
  //       print(value);
  //     });
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  // }

  Future<bool> photoIDMatch() async {
    try {
      final result = await platform.invokeMethod('LivenessCheck');
      print("Result is : $result");
      return result as bool;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
