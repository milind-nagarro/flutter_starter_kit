import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_kit/ui/module/setup_confirm_pin/bloc/setup_confirm_pin_bloc.dart';
import 'package:flutter_starter_kit/ui/screen/common_widget/pinput/pinput.dart';

import '../../../app/app_constant.dart';
import '../../../app/di/locator.dart';
import '../../../app/resources/colors.dart';
import '../../../app/resources/style.dart';
import '../../router/app_router.dart';

class SetupConfirmPinPage extends StatelessWidget {
  SetupConfirmPinPage({Key? key, required this.isConfirmation, this.pinData})
      : super(key: key);
  final bool isConfirmation;
  final String? pinData;

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => SetupConfirmPinBloc())
      ],
      child: Scaffold(
        appBar: FABWidget.appTopBar(
            isConfirmation
                ? AppLocalizations.of(context).confirm_pin
                : AppLocalizations.of(context).set_pin,
            hasCancel: isConfirmation ? false : true, backAction: () {
          if (!isConfirmation) {
            handleBackPress(context);
          } else {
            Navigator.of(context).pop();
          }
        }),
        body: BlocConsumer<SetupConfirmPinBloc, SetupConfirmPinState>(
          listener: (context, state) {
            if (!isConfirmation) {
              if (state.validationState == ValidationState.valid) {
                _moveToConfirmPinScreen(context, textController.text);
              }
            } else {
              _moveToDashboard();
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(12, 50, 0, 0)),
                SetupConfirmPin(forConfirmation: isConfirmation),
                SizedBox(height: 33.h),
                Center(
                    child: Pinput(
                  length: 4,
                  pinAnimationType: PinAnimationType.slide,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  controller: textController,
                  focusNode: focusNode,
                  obscureText: true,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      BlocProvider.of<SetupConfirmPinBloc>(context,
                              listen: false)
                          .add(const ResetState());
                    }

                    BlocProvider.of<SetupConfirmPinBloc>(context, listen: false)
                        .add(PinEntered(pinValue: value));
                  },
                  forceErrorState: isConfirmation &&
                          state.validationState == ValidationState.invalid
                      ? true
                      : state.validationState == ValidationState.invalid
                          ? true
                          : false,
                  errorText: isConfirmation &&
                          state.validationState == ValidationState.invalid
                      ? AppLocalizations.of(context).invalid_pin_number
                      : state.validationState == ValidationState.invalid
                          ? AppLocalizations.of(context).invalid_pin_number
                          : null,
                  obscuringCharacter: '*',
                  errorPinTheme: FABWidget.errorPinTheme,
                  defaultPinTheme: FABWidget.defaultPinTheme,
                  showCursor: false,
                  focusedPinTheme: FABWidget.focusedPinTheme,
                  preFilledWidget:
                      state.validationState == ValidationState.invalid
                          ? null
                          : FABWidget.preFilledWidget,
                  submittedPinTheme: FABWidget.submittedPinTheme,
                )),
                const Spacer(),
                FABWidget.appButton(
                    isConfirmation
                        ? AppLocalizations.of(context).confirm
                        : AppLocalizations.of(context).next,
                    minSize: Size(100.w, 50.h),
                    onPressed: state.buttonState == ValidationState.valid
                        ? () => _handleOnSubmit(context)
                        : null),
                SizedBox(height: 33.h),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleOnSubmit(context) {
    if (isConfirmation) {
      BlocProvider.of<SetupConfirmPinBloc>(context, listen: false).add(
          ConfirmPinSubmit(
              verifyPinData: textController.text, existingPinData: pinData));
    } else {
      BlocProvider.of<SetupConfirmPinBloc>(context, listen: false)
          .add(SetupPinSubmit(pinData: textController.text));
    }
  }

  void _moveToConfirmPinScreen(context, String pinData) {
    locator<AppRouter>().showConfirmPin(pinData);
  }

  void handleBackPress(context) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(AppLocalizations.of(context).pin_cancel_message),
            actions: [
              CupertinoDialogAction(
                  child: Text(AppLocalizations.of(context).yes_cancel),
                  onPressed: () {
                    int count = 0;
                    Navigator.of(context).popUntil((route) => count++ >= 2);
                  }),
              CupertinoDialogAction(
                child: Text(AppLocalizations.of(context).no_stay_here),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _moveToDashboard() {}
}

class SetupConfirmPin extends StatelessWidget {
  const SetupConfirmPin({Key? key, required this.forConfirmation})
      : super(key: key);
  final bool forConfirmation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          forConfirmation
              ? AppLocalizations.of(context).confirm_pin
              : AppLocalizations.of(context).set_pin,
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              fontSize: 21.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          forConfirmation
              ? AppLocalizations.of(context).enter_pin_again
              : AppLocalizations.of(context).create_memorable_pin,
          style: TextStyle(
              fontStyle: FontStyle.normal, fontSize: 14.sp, color: lightGrey),
        ),
      ],
    );
  }
}
