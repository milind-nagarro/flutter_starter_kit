import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_kit/crosscutting/facetec/facetec.dart';
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
                  length: 4,
                  pinAnimationType: PinAnimationType.slide,
                  controller: textController,
                  focusNode: focusNode,
                  obscureText: true,
                  onChanged: (value) {},
                  forceErrorState: false,
                  obscuringCharacter: '*',
                  errorPinTheme: FABWidget.errorPinTheme,
                  errorTextStyle: const TextStyle(color: alertRed),
                  defaultPinTheme: FABWidget.defaultPinTheme,
                  showCursor: false,
                  focusedPinTheme: FABWidget.focusedPinTheme,
                  preFilledWidget: FABWidget.preFilledWidget,
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
                  onPressed: () => {showBottomSheet(context)}),
              SizedBox(height: 33.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showBottomSheet(context) async {
    final faceTec = FaceTec();

    bool isPhotoIDMatchInitiated = false;
    bool isPhotoIDMatchSuccessful = false;

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            height: 356.h,
            child: Column(
              children: [
                Stack(children: [
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(AppLocalizations.of(context).error_message,
                          style: TextStyle(fontSize: 15.sp)),
                    )),
                  ),
                  Positioned(
                      top: 13,
                      right: 13,
                      child: GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 10.r,
                          backgroundColor: greyBackground,
                          child: Image.asset(
                            'assets/images/black_cross.png',
                            width: 20.w,
                            height: 20.h,
                          ),
                        ),
                      ))
                ]),
                Container(
                  color: separatorColor,
                  width: double.infinity,
                  height: 0.5.h,
                ),
                // SizedBox(
                //   height: 15.h,
                // ),
                Container(
                  padding: const EdgeInsets.only(top: 1),
                  color: Colors.white,
                  child: Center(
                    child: Image.asset('assets/images/error_red.png'),
                  ),
                ),
                // SizedBox(
                //   height: 8.h,
                // ),
                Container(
                  padding: const EdgeInsets.all(1),
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    AppLocalizations.of(context).exceeded_number_retries,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
                // SizedBox(
                //   height: 8.h,
                // ),
                FABWidget.appButton(AppLocalizations.of(context).reset_my_pin,
                    minSize: Size(179.w, 30.h), onPressed: () {
                  isPhotoIDMatchInitiated = true;
                  faceTec.getTextFromImage().then((value) {
                    print('value from microblink $value');
                  });
                  // faceTec.photoIDMatch().then((value) {
                  //   isPhotoIDMatchSuccessful = value;
                  // });
                }),
                // SizedBox(
                //   height: 12.h,
                // ),
              ],
            ),
          );
        });
  }
}
