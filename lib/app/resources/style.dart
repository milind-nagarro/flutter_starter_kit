import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ui/screen/common_widget/pinput/pinput.dart';
import 'colors.dart';

class FABStyles {
  // Style for buttons throughout the app
  static ButtonStyle appStyleButton(Color primaryColor,
      {Size? minSize, Color? highlightColor}) {
    return ElevatedButton.styleFrom(
        primary: primaryColor,
        onPrimary: highlightColor ?? Colors.white,
        shadowColor: Colors.grey,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(4.r.toDouble()),
                bottomRight: Radius.circular(12.r.toDouble()),
                topLeft: Radius.circular(12.r.toDouble()),
                bottomLeft: Radius.circular(4.r.toDouble()))),
        minimumSize:
            Size(minSize?.width.w ?? 300.w, minSize?.height.h ?? 56.h));
  }

// Style for button titles throughout the app
  static TextStyle appStyleButtonText(Color color) {
    return TextStyle(
      color: color,
      fontFamily: 'Circular Std',
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
    );
  }

  static TextStyle welcomeHeaderText(Color color) {
    return TextStyle(
      fontSize: 28.sp,
      fontFamily: 'Circular Std',
      fontWeight: FontWeight.w900,
      height: 1.25,
      color: color,
    );
  }

// Style for input text
  static final TextStyle appStyleInputText = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: inputTextColor,
      fontFamily: 'Circular Std');

  static TextStyle textFieldTextStyle(Color color) {
    return TextStyle(
        fontFamily: 'Circular Std',
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp);
  }

// Style for header labels throughout the app
  static TextStyle appStyleHeaderText(Color color) {
    return TextStyle(
      fontSize: 28.sp,
      fontFamily: "Circular Std",
      fontWeight: FontWeight.bold,
      height: 1.25,
      color: color,
    );
  }

  static final TextStyle subHeaderLabelStyle = TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      color: subHeader,
      fontFamily: 'Circular Std');

  static final TextStyle redirectLabelStyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: hintLabel,
      fontFamily: 'Circular Std');

  static final TextStyle errorLabelStyle = TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      color: alertRed,
      fontFamily: 'Circular Std');

  static final appThemeData = ThemeData(
    // primarySwatch: Colors.green,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(primary: primaryLabelColor, secondary: primaryLabelColor),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: primaryLabelColor),
  );
}

// FAB app design specific widgets
class FABWidget {
  static // Button to be used throughout the app
      Widget appButton(String text,
          {Function()? onPressed,
          Color? bgColor,
          Color? textColor,
          Size? minSize,
          Color? highlightColor}) {
    return ElevatedButton(
      style: FABStyles.appStyleButton(bgColor ?? primaryLabelColor,
          minSize: minSize),
      onPressed: onPressed,
      child: Text(
        text,
        style: FABStyles.appStyleButtonText(textColor ?? Colors.white),
      ),
    );
  }

  // top bar with title and back button
  static AppBar appTopBar(
    String title, {
    bool hasCancel = false,
    Function()? backAction,
  }) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: hasCancel
          ? null
          : IconThemeData(color: primaryLabelColor, size: 25.r),
      leadingWidth: hasCancel ? 80.w : null,
      leading: hasCancel
          ? TextButton(
              onPressed: backAction,
              child: Text(
                'cancel',
                style: TextStyle(
                    color: primaryLabelColor,
                    fontFamily: 'SF Pro',
                    fontSize: 15.sp),
              ),
            )
          : BackButton(onPressed: backAction),
      title: Text(
        title,
        style: TextStyle(
            color: headerTextColor, fontFamily: 'SF Pro', fontSize: 16.sp),
      ),
    );
  }

  static PinTheme defaultPinTheme = PinTheme(
    width: 52.w,
    height: 56.h,
    textStyle: TextStyle(color: Colors.black, fontSize: 32.sp),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(4.r)),
    ),
  );

  static PinTheme submittedPinTheme = PinTheme(
    width: 52.w,
    height: 56.h,
    textStyle: TextStyle(color: Colors.black, fontSize: 32.sp),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(4.r)),
    ),
  );

  static PinTheme focusedPinTheme = PinTheme(
    width: 52.w,
    height: 56.h,
    textStyle: TextStyle(color: Colors.black, fontSize: 32.sp),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
          color: Colors.blue, // set border color
          width: 2.0), // set border width
      borderRadius:
          BorderRadius.all(Radius.circular(4.r)), // set rounded corner radius
    ),
  );

  static PinTheme errorPinTheme = PinTheme(
      width: 52.w,
      height: 56.h,
      textStyle: TextStyle(color: alertRed, fontSize: 32.sp));

  static Widget smallTextButton(String title, {Function()? onPressed}) {
    return TextButton(onPressed: onPressed, child: Text(title));
  }

  static Widget textField(
      {TextInputType? keyboardType,
      Function(String text)? onChange,
      String? prefixText,
      String? labelText,
      String? hintText,
      String? errorText,
      Widget? suffixIcon,
      Color? borderColor}) {
    return TextField(
      keyboardType: keyboardType,
      onChanged: onChange,
      style: FABStyles.textFieldTextStyle(Colors.black),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: borderColor ?? textFieldBorderColor)),
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          prefix: (prefixText == null)
              ? null
              : Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Text(prefixText ?? ""),
                      10.horizontalSpace,
                      Text("|"),
                    ],
                  ),
                ),
          // prefixText: prefixText,
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          suffixIcon: suffixIcon,
          labelStyle: FABStyles.textFieldTextStyle(textFieldLabelColor),
          prefixStyle: FABStyles.textFieldTextStyle(textFieldPrefixColor),
          hintStyle: FABStyles.textFieldTextStyle(textFieldHintText),
          errorMaxLines: 2),
    );
  }
}
