import 'package:fab_nhl/crosscutting/analytics/provider/ianalytics_provider.dart';

abstract class IAppAnalytics {
  bool get isTrackingEnabled;

  void addProvider(IAnalyticsProvider provider);
  Future<void> logScreenView(String screenName);
  Future<void> logEvent(String eventName, Map<String, dynamic>? event);
  Future<void> logUserDetails(Map<String, dynamic>? userDetails);
}
