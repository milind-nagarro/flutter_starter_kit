import 'package:fab_nhl/app/resources/assets.dart';
import 'package:fab_nhl/app/resources/colors.dart';
import 'package:fab_nhl/app/resources/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:location/location.dart';
import 'package:app_settings/app_settings.dart';

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
                        onPressed: () {
                          if (widget.type == PermissionType.location) {
                            _askForLocationPermission(context);
                          }
                          //TODO: action based on type
                        },
                      ),
                    )
                  ])),
            ]);
      },
    );

    return Scaffold(
      backgroundColor: appBGColor,
      appBar: FABWidget.appTopBar(headerTitle,
          rightBtnTitle: AppLocalizations.of(context).later,
          rightBtnAction: () => {_nextScreen()}),
      body: column,
    );
  }

  _checkLocationPermissionOnResume() async {
    Location location = Location();
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.granted) {
      _nextScreen();
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
        _nextScreen();
      }
    } else {
      _nextScreen();
    }
  }

  _nextScreen() {
    debugPrint("next screen");
  }

  //// app state observer to check if user went to settings and granted location permission
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("app in resumed");
        if (widget.type == PermissionType.location) {
          _checkLocationPermissionOnResume();
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
