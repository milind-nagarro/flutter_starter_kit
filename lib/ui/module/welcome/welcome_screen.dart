import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_kit/app/app_config.dart';
import 'package:flutter_starter_kit/app/app_constant.dart';
import 'package:flutter_starter_kit/app/di/locator.dart';
import 'package:flutter_starter_kit/app/resources/assets.dart';
import 'package:flutter_starter_kit/app/resources/colors.dart';
import 'package:flutter_starter_kit/app/resources/style.dart';
import 'package:flutter_starter_kit/ui/router/app_router.dart';
import 'package:flutter_starter_kit/ui/screen/common_widget/page_indicator.dart';

import 'cubit/welcome_cubit.dart';
import 'cubit/welcome_state.dart';

/// Widget to display welcome screen
/// Displays images and title according to pages
/// Observes controller to handle UI on swipe
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({required this.lang, Key? key}) : super(key: key);
  final AppLanguage lang;
  @override
  Widget build(BuildContext context) {
    const btnWidth = 312.0;
    const btnHeight = 56.0;
    final bottomSpace = 90.h;
    final topSpace = 80.h;
    final leadingTrailingSpace = 32.w;

// bottom buttons login register
    Widget bottomButtons = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FABWidget.appButton(
          AppLocalizations.of(context).login,
          onPressed: () => {locator<AppRouter>().showLoginScreen()},
          bgColor: Colors.white,
          minSize: const Size(btnWidth, btnHeight),
          textColor: primaryLabelColor,
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: FABWidget.appButton(AppLocalizations.of(context).register,
                onPressed: () =>
                    {locator<AppRouter>().showRegisterMobileScreen()},
                bgColor: Colors.white.withOpacity(0.15)),
          ),
        ),
      ],
    );

// top portion for logo and language switch btn
    Widget topPortion =
        BlocBuilder<WelcomeCubit, WelcomeState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0, bottom: 20.h, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(topLogo),
                TextButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      onPrimary: Colors.grey,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: context.read<LanguageCubit>().changeLanguage,
                    child: BlocBuilder<LanguageCubit, LanguageState>(
                        builder: (context, state) {
                      return Text(
                        state.nextLanguageTitle,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      );
                    })),
              ],
            ),
          ),
          Text(
            ((state.pageNumber == 0)
                ? AppLocalizations.of(context).welcome_msg_1
                : ((state.pageNumber == 1)
                    ? AppLocalizations.of(context).welcome_msg_2
                    : AppLocalizations.of(context).welcome_msg_3)),
            style: FABStyles.appStyleHeaderText(Colors.white),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: buildPageIndicator(
                welcomeScreenTitles.length, state.pageNumber),
          ),
        ],
      );
    });

// scrollable images
    List<Widget> bgImages = [];
    for (var i = 1; i <= welcomeScreenTitles.length; i++) {
      bgImages.add(LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(welcomeImage(i)),
              fit: BoxFit.cover,
            ),
          ),
          child: const SizedBox(),
        );
      }));
    }

    PageController pgcontroller = PageController(
      initialPage: 0,
    );
    Widget pageView = PageView(
        onPageChanged: (page) {
          context.read<WelcomeCubit>().changePage(page);
        },
        controller: pgcontroller,
        children: bgImages);

// stack to lay text and buttons above page view
    Widget stack = Stack(
      children: [
        pageView,
        Positioned(
          child: topPortion,
          top: topSpace,
          left: leadingTrailingSpace,
          right: leadingTrailingSpace,
        ),
        Positioned(
          child: bottomButtons,
          bottom: bottomSpace,
          left: 0,
          right: 0,
        )
      ],
    );

    return BlocProvider(
      create: (context) => LanguageCubit(lang),
      child: Scaffold(body: stack),
    );
  }
}
