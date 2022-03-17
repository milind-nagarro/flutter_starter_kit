import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/domain/entity/article_entity.dart';
import 'package:flutter_starter_kit/ui/module/login/login_screen.dart';
import 'package:flutter_starter_kit/ui/module/welcome/welcome_screen.dart';
import 'package:flutter_starter_kit/ui/screen/article_detail_screen.dart';
import 'package:flutter_starter_kit/ui/screen/article_list_screen.dart';
import 'package:flutter_starter_kit/ui/screen/dashboard_screen.dart';
import 'package:flutter_starter_kit/ui/screen/post_list_screen.dart';
import 'package:flutter_starter_kit/ui/screen/setup_confirm_pin/setup_confirm_pin_screen.dart';

import '../module/registration/register.dart';

// Routes name and mapping to their corresponding screens
const String dashboard = 'dashboard';
const String articleList = 'articleList';
const String articleDetails = 'articleDetails';
const String posts = 'posts';
const String welcome = 'welcome';
const String loginScreen = 'login';
const String registerMobile = 'register_mobile';
const String registerEmail = 'register_email';
const String setupConfirmPin = 'setupConfirmPin';

// define initial route
String get initialRoute => welcome;

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
    case setupConfirmPin:
      return MaterialPageRoute(
          builder: (context) => SetupConfirmPinPage(isConfirmation: false,));
    case welcome:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
    case loginScreen:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case registerMobile:
      return MaterialPageRoute(builder: (context) => const Register(true));
    case registerEmail:
      return MaterialPageRoute(builder: (context) => const Register(false));
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
