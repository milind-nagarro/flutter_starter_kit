import 'package:fab_nhl/crosscutting/crash/iapp_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IAppCrashlytics)
class AppCrashlytics implements IAppCrashlytics {
  AppCrashlytics() {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  Future<void> _initFirebaseApp() => Firebase.initializeApp();

  @override
  bool get isLoggingEnabled =>
      FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;

  @override
  Future<void> enableCrashlytics(bool value) =>
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(value);

  Future<void> _ensureInitialized() async {
    if (Firebase.apps.isEmpty) {
      await _initFirebaseApp();
    }
  }

  @override
  Future<void> logCrash(Exception exception, StackTrace? stackTrace) async {
    await _ensureInitialized();
    FirebaseCrashlytics.instance
        .recordError(exception, stackTrace, fatal: true);
  }

  @override
  Future<void> logError(String error) async {
    await _ensureInitialized();
    FirebaseCrashlytics.instance.recordError(error, null, fatal: false);
  }

  @override
  Future<void> logUserId(String userId) async {
    await _ensureInitialized();
    FirebaseCrashlytics.instance.setUserIdentifier(userId);
  }
}
