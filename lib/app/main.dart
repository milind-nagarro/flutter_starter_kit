import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_kit/app/app_config.dart';
import 'package:flutter_starter_kit/app/resources/theme.dart' as themes;
import 'package:flutter_starter_kit/ui/module/welcome/cubit/welcome_cubit.dart';
import 'package:flutter_starter_kit/ui/router/routes_config.dart' as routes;

import '../ui/router/app_router.dart';
import 'di/locator.dart';

void main() async {
  setupLocator();
  runApp(const StarterKitApp());
}

class StarterKitApp extends StatelessWidget {
  const StarterKitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider<WelcomeCubit>(
            create: (BuildContext context) => WelcomeCubit(),
          ),
        ],
        child: ValueListenableBuilder<AppConfig>(
          valueListenable: locator<AppConfigHandler>().appConfigChangeNotifier,
          builder: (_, config, __) => MaterialApp(
            title: 'FAB NHL',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: config.currentLocale,
            theme: config.currentTheme,
            darkTheme: themes.dark,
            navigatorKey: locator<AppRouter>().navigatorKey,
            onGenerateRoute: routes.generateRoute,
            initialRoute: routes.initialRoute,
          ),
        ),
      ),
    );
  }
}
