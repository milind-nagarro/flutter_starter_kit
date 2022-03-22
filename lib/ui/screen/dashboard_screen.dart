import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fab_nhl/app/app_config.dart';
import 'package:fab_nhl/app/di/locator.dart';
import 'package:fab_nhl/crosscutting/analytics/iapp_analytics.dart';

import '../router/app_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).dashboard)),
      body: _dashboardView(context));

  Widget _dashboardView(BuildContext context) {
    locator<IAppAnalytics>().logScreenView("Dashboard_Screen");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => locator<AppRouter>().showArticleListScreen(),
              child: Text(AppLocalizations.of(context).register)),
          ElevatedButton(
              onPressed: () => locator<AppRouter>().showPostListScreen(),
              child: Text(AppLocalizations.of(context).posts)),
          ElevatedButton(
              onPressed: () => _swapLocale(), child: const Text("EN/AR")),
        ],
      ),
    );
  }

  void _swapLocale() {
    final appConfigHandler = locator<AppConfigHandler>();
    appConfigHandler.swapLocale();
  }
}
