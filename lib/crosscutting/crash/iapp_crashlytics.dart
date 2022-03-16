abstract class IAppCrashlytics {
  bool get isLoggingEnabled;

  Future<void> enableCrashlytics(bool value);

  Future<void> logCrash(Exception exception, StackTrace? stackTrace);
  Future<void> logError(String error);
  Future<void> logUserId(String userId);
}
