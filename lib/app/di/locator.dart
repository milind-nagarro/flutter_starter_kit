import 'package:flutter_starter_kit/app/di/network_module.dart';
import 'package:flutter_starter_kit/crosscutting/analytics/app_analytics.dart';
import 'package:flutter_starter_kit/crosscutting/analytics/iapp_analytics.dart';
import 'package:flutter_starter_kit/crosscutting/analytics/provider/firebase_analytics_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'locator.config.dart';

final locator = GetIt.instance;

@injectableInit
void setupLocator() {
  _init(locator);
  $initGetIt(locator);
}

void _init(GetIt locator) {
  NetworkModule.init(locator);

  locator.registerLazySingleton<IAppAnalytics>(
      () => AppAnalytics()..addProvider(FirebaseAnalyticsProvider()));
}
