import 'package:flutter/foundation.dart';
import 'package:fab_nhl/crosscutting/analytics/iapp_analytics.dart';
import 'package:fab_nhl/crosscutting/analytics/provider/ianalytics_provider.dart';

class AppAnalytics implements IAppAnalytics {
  final providers = <IAnalyticsProvider>[];

  @override
  bool get isTrackingEnabled => !kReleaseMode;

  @override
  void addProvider(IAnalyticsProvider provider) async {
    providers.add(provider);
  }

  @override
  Future<void> logEvent(String eventName, Map<String, dynamic>? event) async {
    if (isTrackingEnabled) {
      for (var provider in providers) {
        await provider.logEvent(eventName, event);
      }
    }
  }

  @override
  Future<void> logScreenView(String screenName) async {
    if (isTrackingEnabled) {
      for (var provider in providers) {
        await provider.logScreenView(screenName);
      }
    }
  }

  @override
  Future<void> logUserDetails(Map<String, dynamic>? userDetails) async {
    if (isTrackingEnabled) {
      for (var provider in providers) {
        await provider.logUserDetails(userDetails);
      }
    }
  }
}
