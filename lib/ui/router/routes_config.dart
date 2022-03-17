import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_starter_kit/domain/entity/article_entity.dart';
import 'package:flutter_starter_kit/ui/screen/article_detail_screen.dart';
import 'package:flutter_starter_kit/ui/screen/article_list_screen.dart';
import 'package:flutter_starter_kit/ui/screen/dashboard_screen.dart';
import 'package:flutter_starter_kit/ui/screen/post_list_screen.dart';
import 'package:flutter_starter_kit/ui/screen/setup_confirm_pin/setup_confirm_pin_screen.dart';

// Routes name and mapping to their corresponding screens
const String dashboard = 'dashboard';
const String articleList = 'articleList';
const String articleDetails = 'articleDetails';
const String posts = 'posts';
const String setupConfirmPin = 'setupConfirmPin';

// define initial route
String get initialRoute => setupConfirmPin;

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
