import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_kit/ui/screen/common_widget/pinput/pinput.dart';

import '../../../app/resources/colors.dart';
import '../../../app/resources/style.dart';

class SetupConfirmPinPage extends StatelessWidget {
  SetupConfirmPinPage({Key? key, required this.isConfirmation})
      : super(key: key);
  final bool isConfirmation;

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FABWidget.appTopBar(
          isConfirmation
              ? AppLocalizations.of(context).confirm_pin
              : AppLocalizations.of(context).set_pin,
          hasCancel: isConfirmation ? false : true, backAction: () {
        handleBackPress(context);
      }),
      body: Column(
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
            onChanged: (value) {},
            obscureText: true,
            obscuringCharacter: '*',
            errorPinTheme: FABWidget.errorPinTheme,
            defaultPinTheme: FABWidget.defaultPinTheme,
            showCursor: false,
            focusedPinTheme: FABWidget.focusedPinTheme,
            preFilledWidget: FABWidget.preFilledWidget,
            submittedPinTheme: FABWidget.submittedPinTheme,
          )),
          const Spacer(),
          FABWidget.appButton(
              isConfirmation
                  ? AppLocalizations.of(context).confirm
                  : AppLocalizations.of(context).next,
              bgColor: Colors.grey,
              minSize: Size(100.w, 50.h),
              onPressed: () => {}),
          SizedBox(height: 33.h),
        ],
      ),
    );
  }

  void handleBackPress(context) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(
                AppLocalizations.of(context).pin_cancel_message
            ),
            actions: [
              CupertinoDialogAction(
                  child: Text(
                      AppLocalizations.of(context).yes_cancel
                  ), onPressed: () {}),
              CupertinoDialogAction(
                child: Text(
                    AppLocalizations.of(context).no_stay_here
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
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
