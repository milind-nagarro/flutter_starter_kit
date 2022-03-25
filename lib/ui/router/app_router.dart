import 'package:fab_nhl/app/app_constant.dart';
import 'package:fab_nhl/data/remote/response/user_response.dart';
import 'package:fab_nhl/domain/entity/article_entity.dart';
import 'package:fab_nhl/ui/module/welcome/welcome_screen.dart';
import 'package:fab_nhl/ui/router/navigation_service.dart';
import 'package:fab_nhl/ui/router/routes_config.dart' as routes;
import 'package:fab_nhl/ui/screen/common_widget/permission_screen.dart';
import 'package:flutter/widgets.dart';
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

  void showRegisterEmailScreen({bool isReplace = false}) {
    isReplace
        ? _navService.pushReplacementNamed(routes.registerEmail)
        : _navService.pushNamed(routes.registerEmail);
  }

  void showWelcomeAfterSplash({required AppLanguage language}) {
    _navService.pushReplacementNoAnimation(WelcomeScreen(
      lang: language,
    ));
  }

  void showSetupPin() {
    _navService.pushNamed(routes.setupPin);
  }

  void showConfirmPin(String pinData) {
    _navService.pushNamed(routes.confirmPin, args: pinData);
  }

// TODO: use DI for logged user instead of passing the object everywhere
  void showVerifyPin({User? user}) {
    _navService.pushReplacementNamed(routes.verifyPin, args: user);
  }

  void showVerificationScreen(List<dynamic> args) {
    _navService.pushNamed(routes.verification, args: args);
  }

  void goBack() {
    _navService.goBack();
  }

  void showPermissionScreen(PermissionType type) {
    switch (type) {
      case PermissionType.location:
        _navService.pushReplacementNamed(routes.permissionLocation);
        break;
      case PermissionType.faceid:
        _navService.pushReplacementNamed(routes.permissionFaceid);
        break;
    }
  }

  void showDashboard() {
    _navService.pushReplacementNamed(routes.dashboard);
  }
}
