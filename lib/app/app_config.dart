import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_starter_kit/app/app_constant.dart';
import 'package:flutter_starter_kit/app/resources/theme.dart' as theme;
import 'package:injectable/injectable.dart';

const String _defaultLocaleCountryCode = 'en';

class AppConfig {
  final Locale currentLocale;
  final ThemeData currentTheme;

  AppConfig(this.currentLocale, this.currentTheme);
}

@lazySingleton
class AppConfigHandler {
  AppConfig get configuration => appConfigChangeNotifier.value;

  final appConfigChangeNotifier = ValueNotifier<AppConfig>(AppConfig(
      AppLocalizations.supportedLocales.firstWhere(
          (locale) => locale == const Locale(_defaultLocaleCountryCode)),
      theme.light));

  void swapLocale() {
    setLocale(configuration.currentLocale.languageCode == localeEn
        ? localeAr
        : localeEn);
  }

  void setLocale(String locale) {
    _notifyChanges(AppConfig(Locale(locale), configuration.currentTheme));
  }

  void setTheme(ThemeData newTheme) {
    _notifyChanges(AppConfig(configuration.currentLocale, newTheme));
  }

  void _notifyChanges(AppConfig newConfig) {
    appConfigChangeNotifier.value = newConfig;
  }
}
