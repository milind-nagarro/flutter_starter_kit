import 'package:fab_nhl/app/app_config.dart';
import 'package:fab_nhl/app/di/locator.dart';
import 'package:fab_nhl/ui/module/welcome/cubit/welcome_cubit.dart';
import 'package:fab_nhl/ui/router/routes_config.dart' as routes;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ui/router/app_router.dart';

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
            builder: (context, widget) {
              ScreenUtil.setContext(context);
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            title: 'FAB NHL',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: config.currentLocale,
            theme: config.currentTheme,
            /*darkTheme: themes.dark,*/
            debugShowCheckedModeBanner: false,
            navigatorKey: locator<AppRouter>().navigatorKey,
            onGenerateRoute: routes.generateRoute,
            initialRoute: routes.initialRoute,
          ),
        ),
      ),
      designSize: const Size(375, 812),
    );
  }
}
