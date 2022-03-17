import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/app/app_config.dart';
import 'package:flutter_starter_kit/app/app_constant.dart';
import 'package:flutter_starter_kit/app/di/locator.dart';
import 'package:flutter_starter_kit/app/prefs/local_storage.dart';
import 'package:flutter_starter_kit/app/resources/assets.dart';
import 'package:flutter_starter_kit/ui/router/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(splashImage),
            fit: BoxFit.cover,
          ),
        ),
        child: const SizedBox(),
      );
    }));
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    // default language is english. check if user has changed it and set locale accordingly
    final langPref = await LocalStorage.getLanguagePreference();
    locator<AppConfigHandler>()
        .setLocale(langPref == AppLanguage.arabic.index ? localeAr : localeEn);
    locator<AppRouter>().showWelcomeAfterSplash(
        language: (langPref == AppLanguage.arabic.index)
            ? AppLanguage.arabic
            : AppLanguage.english);
  }
}
