import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_kit/app/resources/app_constants.dart';
import 'package:flutter_starter_kit/app/resources/assets.dart';
import 'package:flutter_starter_kit/app/resources/colors.dart';
import 'package:flutter_starter_kit/app/resources/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/login_bloc.dart';
import 'cubit/remember_me_cubit.dart';

/// Login Screen widget.
/// Contains text field to input mobile number and display error if invalid number
/// used bloc to validate number and navigation to next screen
/// also uses cubit for remember me toggle
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RememberMeCubit(),
        ),
      ],
      child: Scaffold(
        appBar: FABWidget.appTopBar(AppLocalizations.of(context).login),
        // bloc consumer for listening to login state for navigation and validation based UI
        body: BlocConsumer<LoginBloc, LoginState>(builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context).welcome_back,
                        style: FABStyles.subHeaderLabelStyle),
                    SizedBox(height: 8.h),
                    Text(
                      AppLocalizations.of(context).login_header,
                      style: FABStyles.appStyleHeaderText(header),
                    ),
                    SizedBox(height: 40.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (text) {
                          BlocProvider.of<LoginBloc>(context, listen: false)
                              // context.read<LoginBloc>() // context.read should not be used inside build, but in callbacks
                              .add(LoginPhoneNumberChanged(text));
                        },
                        style: FABStyles.appStyleInputText,
                        decoration: InputDecoration(
                            filled: false,
                            prefixText: uaeCode,
                            labelText:
                                AppLocalizations.of(context).mobile_number,
                            errorText: (state.loginStatus ==
                                    LoginStates.unauthenticated)
                                ? AppLocalizations.of(context).not_registered
                                : null,
                            suffixIcon: (state.loginStatus ==
                                    LoginStates.unauthenticated)
                                ? Image.asset(errorIconTextField)
                                : null,
                            errorMaxLines: 2),
                      ),
                    ),
                    Row(children: [
                      BlocBuilder<RememberMeCubit, RememberMeValue>(
                          builder: (context, state) {
                        return Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          value: (state.userSelection),
                          onChanged: (bool? value) {
                            context.read<RememberMeCubit>().toggleSelection();
                          },
                          fillColor:
                              MaterialStateProperty.all(primaryLabelColor),
                        );
                      }),
                      GestureDetector(
                        onTap: () =>
                            context.read<RememberMeCubit>().toggleSelection(),
                        child: Text(AppLocalizations.of(context).remember_me),
                      ),
                      const Spacer(),
                      FABWidget.smallTextButton(
                          AppLocalizations.of(context).not_yet_registered,
                          onPressed: () =>
                              {}), //controller.navigateToRegisterScreen()}),
                    ]),
                  ],
                ),
                Positioned(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: SizedBox(
                      width: 116.w,
                      height: 56.h,
                      child: FABWidget.appButton(
                        AppLocalizations.of(context).next,
                        onPressed: nextStep(context, state),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        }, // listener for navigation to next screen when login succeeds
            listener: (context, state) {
          if (state.loginStatus == LoginStates.authenticated) {
            nextScreen();
          }
        }),
      ),
    );
  }

  Function()? nextStep(BuildContext context, LoginState state) {
    if (state.loginStatus == LoginStates.unauthenticated) {
      return null;
    }
    switch (state.validationStatus) {
      case ValidationState.notChecked:
        return null;
      case ValidationState.invalid:
        return null;
      case ValidationState.valid:
        return () {
          FocusManager.instance.primaryFocus?.unfocus();
          BlocProvider.of<LoginBloc>(context, listen: false)
              .
              // context.read<LoginBloc>().
              add(const LoginSubmitted());
        };
    }
  }

  void nextScreen() {
    // final LoginScreenController controller = Get.find();
    // controller.nextScreen();
  }
}
