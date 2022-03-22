import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_kit/app/app_constant.dart';
import 'package:flutter_starter_kit/app/resources/colors.dart';
import 'package:flutter_starter_kit/app/resources/style.dart';
import 'package:flutter_starter_kit/ui/module/verification/bloc/verification_bloc.dart';
import 'package:flutter_starter_kit/ui/screen/common_widget/pinput/pinput.dart';
import 'package:timer_count_down/timer_count_down.dart';

/// widget to create verification screen
/// pass constructor 'true' registering for mobile,'false' for email
class Verification extends StatelessWidget {
  Verification(this.argument, {Key? key}) : super(key: key);

  final List<dynamic> argument;
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = argument[0];
    final String inputToVerify = argument[1];
    VerificationBloc verificationBloc = VerificationBloc(isMobile);

    return Scaffold(
        appBar: FABWidget.appTopBar(AppLocalizations.of(context).your_otp),
        backgroundColor: appBGColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
            child: Container(
              child: BlocProvider(
                create: (BuildContext context) {
                  return verificationBloc;
                },
                child: BlocConsumer<VerificationBloc, VerificationState>(
                  builder: (context, state) {
                    return Stack(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context).enter_verification,
                              style: FABStyles.appStyleHeaderText(header)),
                          SizedBox(height: 8.h),
                          Text(
                              isMobile
                                  ? AppLocalizations.of(context)
                                          .verification_sent_msg_mobile +
                                      " (" +
                                      inputToVerify +
                                      ")"
                                  : AppLocalizations.of(context)
                                          .verification_sent_msg_email +
                                      " " +
                                      inputToVerify,
                              style: FABStyles.subHeaderLabelStyle),
                          SizedBox(height: 60.h),
                          Center(
                              child: Pinput(
                            length: 6,
                            pinAnimationType: PinAnimationType.slide,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            controller: verificationBloc.textController,
                            focusNode: focusNode,
                            onChanged: (value) {
                              verificationBloc.add(ValueUpdated(value));
                            },
                            obscureText: true,
                            errorPinTheme: FABWidget.errorPinTheme,
                            defaultPinTheme: FABWidget.defaultPinTheme,
                            showCursor: false,
                            focusedPinTheme: FABWidget.focusedPinTheme,
                            submittedPinTheme: FABWidget.submittedPinTheme,
                            forceErrorState: state.serverValidationStatus ==
                                ValidationState.invalid,
                            errorText: state.serverValidationStatus ==
                                    ValidationState.invalid
                                ? AppLocalizations.of(context).otp_expired
                                : null,
                          )),
                          SizedBox(height: 16.h),
                          Countdown(
                            controller: verificationBloc.countdownController,
                            seconds: otpExpireTime,
                            build: (BuildContext context, double time) => Text(
                                AppLocalizations.of(context).otp_expire_msg +
                                    verificationBloc.formatedTime(time.round()),
                                style: FABStyles.subHeaderLabelStyle,
                                textAlign: TextAlign.center),
                            interval: const Duration(milliseconds: 1000),
                            onFinished: () {
                              verificationBloc.add(const TimeExpireEvent());
                            },
                          ),
                          SizedBox(height: 16.h),
                          SizedBox(
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: () =>
                                    verificationBloc.add(const ResendEvent()),
                                child: Text(
                                    AppLocalizations.of(context).resend_code,
                                    style: FABStyles.redirectLabelStyle,
                                    textAlign: TextAlign.center),
                              )),
                        ],
                      ),
                      Positioned(
                          child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: FABWidget.appButton(
                            AppLocalizations.of(context).next,
                            onPressed:
                                verificationBloc.nextStep(context, state)),
                      )),
                    ]);
                  },
                  listener: (context, state) {
                    if (state.serverValidationStatus == ValidationState.valid) {
                      verificationBloc.navigateToNextScreen();
                    }
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
