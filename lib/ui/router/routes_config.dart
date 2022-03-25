import 'package:fab_nhl/data/remote/response/user_response.dart';
import 'package:fab_nhl/domain/entity/article_entity.dart';
import 'package:fab_nhl/ui/module/dashboard/dashboard.dart';
import 'package:fab_nhl/ui/module/login/login_screen.dart';
import 'package:fab_nhl/ui/module/splash/splash.dart';
import 'package:fab_nhl/ui/module/verification/verification.dart';
import 'package:fab_nhl/ui/module/verify_pin/verify_pin_screen.dart';
import 'package:fab_nhl/ui/screen/article_detail_screen.dart';
import 'package:fab_nhl/ui/screen/article_list_screen.dart';
import 'package:fab_nhl/ui/screen/common_widget/permission_screen.dart';
import 'package:fab_nhl/ui/screen/post_list_screen.dart';
import 'package:flutter/material.dart';

import '../module/registration/register.dart';
import '../module/setup_confirm_pin/setup_confirm_pin_screen.dart';

// Routes name and mapping to their corresponding screens
const String dashboard = 'dashboard';
const String articleList = 'articleList';
const String articleDetails = 'articleDetails';
const String posts = 'posts';
const String loginScreen = 'login';
const String registerMobile = 'register_mobile';
const String registerEmail = 'register_email';
const String splash = 'splash';
const String setupPin = 'setupPin';
const String confirmPin = 'confirmPin';
const String verifyPin = 'verifyPin';
const String verification = 'verification';
const String permissionLocation = 'permissionLocation';
const String permissionFaceid = 'permissionFaceid';

// define initial route
String get initialRoute => splash;

// configuration for routing with parameters
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case dashboard:
      return MaterialPageRoute(builder: (context) => const Dashboard());
    case articleList:
      return MaterialPageRoute(builder: (context) => const ArticleListScreen());
    case articleDetails:
      return MaterialPageRoute(
          builder: (context) =>
              ArticleDetailScreen(settings.arguments as ArticleEntity));
    case posts:
      return MaterialPageRoute(builder: (context) => const PostListScreen());
    case setupPin:
      return MaterialPageRoute(
          builder: (context) => SetupConfirmPinPage(
                isConfirmation: false,
              ));
    case confirmPin:
      return MaterialPageRoute(
          builder: (context) => SetupConfirmPinPage(
              isConfirmation: true, pinData: settings.arguments as String));
    case loginScreen:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case registerMobile:
      return MaterialPageRoute(builder: (context) => const Register(true));
    case registerEmail:
      return MaterialPageRoute(builder: (context) => const Register(false));
    case verification:
      return MaterialPageRoute(
          builder: (context) =>
              Verification(settings.arguments as List<dynamic>));
    case splash:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case verifyPin:
      return MaterialPageRoute(
          builder: (context) => VerifyPinScreen(
                fromLogin: settings.arguments as bool,
              ));
    case permissionFaceid:
      return MaterialPageRoute(
          builder: (context) =>
              const PermissionScreen(type: PermissionType.faceid));
    case permissionLocation:
      return MaterialPageRoute(
          builder: (context) =>
              const PermissionScreen(type: PermissionType.location));
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
