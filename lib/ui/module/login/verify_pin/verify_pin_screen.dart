import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_kit/ui/screen/common_widget/pinput/pinput.dart';

import '../../../../app/resources/colors.dart';
import '../../../../app/resources/style.dart';

class VerifyPinScreen extends StatelessWidget {
  const VerifyPinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    FocusNode focusNode = FocusNode();

    return Scaffold(
      appBar: FABWidget.appTopBar(AppLocalizations.of(context).pin),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Column(
            children: [
              Text(AppLocalizations.of(context).welcome_back,
                  style: FABStyles.subHeaderLabelStyle),
              SizedBox(height: 8.h),
              Text(
                AppLocalizations.of(context).type_pin_number,
                style: FABStyles.appStyleHeaderText(header),
              ),
              SizedBox(height: 33.h),
              Center(
                child: Pinput(
                  length: 6,
                  pinAnimationType: PinAnimationType.slide,
                  controller: textController,
                  focusNode: focusNode,
                  obscureText: true,
                  onChanged: (value) {},
                  forceErrorState: false,
                  errorPinTheme: FABWidget.errorPinTheme,
                  errorTextStyle: const TextStyle(color: alertRed),
                  defaultPinTheme: FABWidget.defaultPinTheme,
                  showCursor: false,
                  focusedPinTheme: FABWidget.focusedPinTheme,
                  /*preFilledWidget: FABWidget.preFilledWidget,*/
                  submittedPinTheme: FABWidget.submittedPinTheme,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                AppLocalizations.of(context).forgot_your_pin,
                style: const TextStyle(color: borderColor),
              ),
              const Spacer(),
              FABWidget.appButton(AppLocalizations.of(context).next,
                  bgColor: Colors.blue,
                  minSize: Size(100.w, 50.h),
                  onPressed: () => {}),
              SizedBox(height: 33.h),
            ],
          ),
        ),
      ),
    );
  }
}
