import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/domain/entity/article_entity.dart';
import 'package:flutter_starter_kit/ui/module/login/login_screen.dart';
import 'package:flutter_starter_kit/ui/module/login/verify_pin/verify_pin_screen.dart';
import 'package:flutter_starter_kit/ui/module/splash/splash.dart';
import 'package:flutter_starter_kit/ui/module/verification/verification.dart';
import 'package:flutter_starter_kit/ui/screen/article_detail_screen.dart';
import 'package:flutter_starter_kit/ui/screen/article_list_screen.dart';
import 'package:flutter_starter_kit/ui/screen/dashboard_screen.dart';
import 'package:flutter_starter_kit/ui/screen/post_list_screen.dart';

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

// define initial route
String get initialRoute => verifyPin;

// configuration for routing with parameters
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case dashboard:
      return MaterialPageRoute(builder: (context) => const DashboardScreen());
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
      return MaterialPageRoute(builder: (context) => const VerifyPinScreen());
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
