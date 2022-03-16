abstract class IAnalyticsProvider {
  Future<void> logScreenView(String screenName);
  Future<void> logEvent(String eventName, Map<String, dynamic>? event);
  Future<void> logUserDetails(Map<String, dynamic>? userDetails);
}
