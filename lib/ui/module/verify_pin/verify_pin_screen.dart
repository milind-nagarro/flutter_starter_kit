import 'package:fab_nhl/app/resources/colors.dart';
import 'package:fab_nhl/app/resources/style.dart';
import 'package:fab_nhl/data/remote/response/user_response.dart';
import 'package:fab_nhl/ui/module/verify_pin/cubit/verifypin_cubit.dart';
import 'package:fab_nhl/ui/router/app_router.dart';
import 'package:fab_nhl/ui/screen/common_widget/pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/app_constant.dart';
import '../../../app/di/locator.dart';

class VerifyPinScreen extends StatelessWidget {
  const VerifyPinScreen({Key? key, required this.loggedUser}) : super(key: key);
  final User loggedUser;
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    FocusNode focusNode = FocusNode();

    return BlocProvider(
      create: (context) => VerifypinCubit(loggedUser),
      child: Scaffold(
        appBar: FABWidget.appTopBar(AppLocalizations.of(context).login,
            hidesBack: true /*(userJson != null)*/,
            rightBtnTitle: AppLocalizations.of(context).not_you,
            rightBtnAction: () => {
                  //TODO: handle action
                }),
        backgroundColor: appBGColor,
        body: BlocBuilder<VerifypinCubit, VerifypinInitial>(
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${AppLocalizations.of(context).welcome_back}',
                        style: FABStyles.appStyleHeaderText(header)),
                    SizedBox(height: 8.h),
                    Text(
                      AppLocalizations.of(context).type_pin_number,
                      style: FABStyles.subHeaderLabelStyle,
                    ),
                    SizedBox(height: 33.h),
                    Center(
                      child: Pinput(
                        length: 6,
                        pinAnimationType: PinAnimationType.slide,
                        controller: textController,
                        focusNode: focusNode,
                        obscureText: true,
                        onChanged: (value) =>
                            {context.read<VerifypinCubit>().pinUpdated(value)},
                        forceErrorState: state.isVerified == false ||
                            state.maxRetriesAttempted,
                        errorPinTheme: FABWidget.errorPinTheme,
                        errorTextStyle: const TextStyle(color: alertRed),
                        defaultPinTheme: FABWidget.defaultPinTheme,
                        showCursor: false,
                        focusedPinTheme: FABWidget.focusedPinTheme,
                        submittedPinTheme: FABWidget.submittedPinTheme,
                      ),
                    ),
                    SizedBox(
                      height: 19.h,
                    ),
                    Visibility(
                        visible: state.isValid == ValidationState.invalid &&
                            !state.maxRetriesAttempted,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 8.0),
                          child: Text(
                              AppLocalizations.of(context).enter_correct_pin,
                              textAlign: TextAlign.left,
                              style: FABStyles.errorLabelStyle),
                        )),
                    Visibility(
                        visible: state.isValid == ValidationState.invalid &&
                            state.maxRetriesAttempted,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 8.0),
                          child: Text(
                              AppLocalizations.of(context)
                                  .exceeded_number_retries,
                              textAlign: TextAlign.left,
                              style: FABStyles.errorLabelStyle),
                        )),
                    SizedBox(height: 16.h),
                    Align(
                        child: TextButton(
                            onPressed: () =>
                                {locator<AppRouter>().showForgotPinScreen()},
                            child: Text(
                              AppLocalizations.of(context).forgot_your_pin,
                              style: const TextStyle(color: borderColor),
                            ))),
                    const Spacer(),
                    Align(
                      child: FABWidget.appButton(
                          AppLocalizations.of(context).next,
                          // bgColor: Colors.blue,
                          // minSize: Size(300.w, 50.h),
                          onPressed: state.maxRetriesAttempted
                              ? null
                              : context.read<VerifypinCubit>().nextStep()),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
