import 'package:flutter/widgets.dart';
import 'package:flutter_starter_kit/domain/entity/article_entity.dart';
import 'package:flutter_starter_kit/ui/router/navigation_service.dart';
import 'package:flutter_starter_kit/ui/router/routes_config.dart' as routes;
import 'package:injectable/injectable.dart';

@injectable
class AppRouter {
  final NavigationService _navService;

  AppRouter(this._navService);

  GlobalKey<NavigatorState> get navigatorKey => _navService.navigatorKey;

  void showArticleListScreen() {
    _navService.pushNamed(routes.articleList);
  }

  void showArticleDetailScreen(ArticleEntity articleEntity) {
    _navService.pushNamed(routes.articleDetails, args: articleEntity);
  }

  void showPostListScreen() {
    _navService.pushNamed(routes.posts);
  }

  void showLoginScreen() {
    _navService.pushNamed(routes.loginScreen);
  }

  void showRegisterMobileScreen() {
    _navService.pushNamed(routes.registerMobile);
  }

  void showRegisterEmailScreen() {
    _navService.pushNamed(routes.registerEmail);
  }
}
