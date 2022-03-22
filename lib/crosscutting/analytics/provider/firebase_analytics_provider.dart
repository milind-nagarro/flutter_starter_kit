import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fab_nhl/crosscutting/analytics/provider/ianalytics_provider.dart';

class FirebaseAnalyticsProvider implements IAnalyticsProvider {
  Future<void> _ensureInitialized() async {
    if (Firebase.apps.isEmpty) await Firebase.initializeApp();
  }

  @override
  Future<void> logEvent(String eventName, Map<String, dynamic>? event) async {
    await _ensureInitialized();
    FirebaseAnalytics.instance.logEvent(name: eventName, parameters: event);
  }

  @override
  Future<void> logScreenView(String screenName) async {
    await _ensureInitialized();
    FirebaseAnalytics.instance.logScreenView(screenName: screenName);
  }

  @override
  Future<void> logUserDetails(Map<String, dynamic>? userDetails) async {
    await _ensureInitialized();
    userDetails?.forEach((key, value) async {
      await FirebaseAnalytics.instance
          .setUserProperty(name: key, value: userDetails[key]);
    });
  }
}
