import 'package:app_settings/app_settings.dart';
import 'package:fab_nhl/app/di/locator.dart';
import 'package:fab_nhl/app/prefs/local_storage.dart';
import 'package:fab_nhl/app/resources/assets.dart';
import 'package:fab_nhl/app/resources/colors.dart';
import 'package:fab_nhl/app/resources/style.dart';
import 'package:fab_nhl/ui/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:location/location.dart';

import '../../../app/biometric_authenticator.dart';

enum PermissionType {
  location,
  faceid,
}

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({required this.type, key}) : super(key: key);
  final PermissionType type;

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    // conditional texts
    dynamic headerTitle, title, subtitle, iconName;
    if ((widget.type == PermissionType.location)) {
      title = AppLocalizations.of(context).location_title;
      subtitle = AppLocalizations.of(context).location_subtitle;
      headerTitle = AppLocalizations.of(context).location_header_title;
      iconName = icLocationPermission;
    } else {
      title = AppLocalizations.of(context).faceid_title;
      subtitle = AppLocalizations.of(context).faceid_subtitle;
      headerTitle = AppLocalizations.of(context).faceid_header_title;
      iconName = icFaceidPermission;
    }
    // main body of the widget
    Widget column = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight / 2,
                  child: Center(
                    child: SizedBox(
                        height: constraints.maxWidth * 0.85,
                        width: constraints.maxWidth * 0.85,
                        child: Image.asset(iconName)),
                  )),
              SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight / 2,
                  child: Column(children: [
                    Text(
                      title,
                      style: FABStyles.appStyleHeaderText(headerTextColor),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: Text(
                        subtitle,
                        style: FABStyles.subHeaderLabelStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 40.h),
                      child: FABWidget.appButton(
                        AppLocalizations.of(context).allow_access_btn,
                        bgColor: primaryLabelColor,
                        onPressed: _onAllowAccess,
                      ),
                    )
                  ])),
            ]);
      },
    );

    return Scaffold(
      backgroundColor: appBGColor,
      appBar: FABWidget.appTopBar(headerTitle,
          hidesBack: true,
          rightBtnTitle: AppLocalizations.of(context).later,
          rightBtnAction: _onLaterClicked),
      body: column,
    );
  }

  _onAllowAccess() {
    switch (widget.type) {
      case PermissionType.location:
        _askForLocationPermission(context);
        break;
      case PermissionType.faceid:
        _nextScreenFaceid();
        break;
    }
  }

  _onLaterClicked() {
    switch (widget.type) {
      case PermissionType.location:
        _nextScreenLocation();
        break;
      case PermissionType.faceid:
        locator<AppRouter>().showDashboard();
        break;
    }
  }

  _checkLocationPermissionOnResume() async {
    Location location = Location();
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.granted) {
      LocalStorage.storeFaceidPreference(true);
      _nextScreenLocation();
    }
  }

  _askForLocationPermission(BuildContext context) async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    debugPrint('checking service enabled');
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      debugPrint('service not enabled. requesting..');
      _serviceEnabled = await location.requestService();
      debugPrint('service request enabled $_serviceEnabled');
      if (!_serviceEnabled) {
        return;
      }
    }
    debugPrint('checking for location permission');
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      debugPrint('location permission denied. requesting');
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        debugPrint('location permission not granted');
        FABWidget.showAlertDialog(
            context,
            AppLocalizations.of(context).location_title,
            AppLocalizations.of(context).settings,
            contentStr: AppLocalizations.of(context).location_denied_msg,
            cancelTitle: AppLocalizations.of(context).cancel,
            okAction: () => {AppSettings.openLocationSettings()});

        // return;
      } else {
        debugPrint('location permission granted');
        _nextScreenLocation();
      }
    } else {
      _nextScreenLocation();
    }
  }

  _nextScreenLocation() async {
    debugPrint("next screen");
    if (await BioMetricAuthentication.isBiometricAvailable()) {
      locator<AppRouter>().showPermissionScreen(PermissionType.faceid);
    } else {
      locator<AppRouter>().showDashboard();
    }
  }

  _nextScreenFaceid() async {
    try {
      bool isAuthenticated =
          await BioMetricAuthentication.authenticateWithBiometrics();
      if (isAuthenticated) {
        locator<AppRouter>().showDashboard();
      } else {
        debugPrint("isAuthenticated failed");
      }
    } on PlatformException catch (e) {
      FABWidget.showAlertDialog(
        context,
        e.message.toString(),
        AppLocalizations.of(context).ok,
      );
    }
  }

  //// app state observer to check if user went to settings and granted location permission
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("app in resumed");
        if (widget.type == PermissionType.location) {
          // _checkLocationPermissionOnResume();
        }

        break;
      case AppLifecycleState.inactive:
        debugPrint("app in inactive");
        break;
      case AppLifecycleState.paused:
        debugPrint("app in paused");
        break;
      case AppLifecycleState.detached:
        debugPrint("app in detached");
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}
