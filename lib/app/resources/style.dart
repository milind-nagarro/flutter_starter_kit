import 'package:fab_nhl/app/resources/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ui/screen/common_widget/pinput/pinput.dart';
import 'colors.dart';

class FABStyles {
  // Style for buttons throughout the app
  static ButtonStyle appStyleButton(Color primaryColor,
      {Size? minSize, Color? highlightColor}) {
    return ElevatedButton.styleFrom(
        primary: Colors.transparent,
        /*primary: primaryColor,
        onPrimary: highlightColor ?? Colors.white,*/
        shadowColor: Colors.transparent,
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
      fontFamily: themeFont,
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
    );
  }

  static TextStyle welcomeHeaderText(Color color) {
    return TextStyle(
      fontSize: 28.sp,
      fontFamily: themeFont,
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
      fontFamily: themeFont);

  static TextStyle textFieldTextStyle(Color color) {
    return TextStyle(
        fontFamily: themeFont,
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp);
  }

// Style for header labels throughout the app
  static TextStyle appStyleHeaderText(Color color) {
    return TextStyle(
      fontSize: 24.sp,
      fontFamily: themeFont,
      fontWeight: FontWeight.bold,
      height: 1.25.h,
      letterSpacing: 0.33.sp,
      color: color,
    );
  }

  static final TextStyle subHeaderLabelStyle = TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      color: subHeader,
      letterSpacing: 0.33.sp,
      fontFamily: themeFont);

  static final TextStyle redirectLabelStyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: hintLabel,
      fontFamily: themeFont);

  static final TextStyle errorLabelStyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: errorRed,
      fontFamily: themeFont);

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
          bool isGradient = true,
          Color? bgColor,
          Color? textColor,
          Size? minSize,
          Color? highlightColor}) {
    return Container(
      height: minSize?.height.h ?? 56.h,
      width: minSize?.width.w ?? 300.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(4.r.toDouble()),
              bottomRight: Radius.circular(12.r.toDouble()),
              topLeft: Radius.circular(12.r.toDouble()),
              bottomLeft: Radius.circular(4.r.toDouble())),
          gradient: isGradient && onPressed != null
              ? const LinearGradient(
                  colors: [buttonGradientStart, buttonGradientEnd])
              : null,
          color:
              onPressed != null ? bgColor ?? primaryLabelColor : Colors.grey),
      child: ElevatedButton(
        style: FABStyles.appStyleButton(bgColor ?? primaryLabelColor,
            minSize: minSize),
        onPressed: onPressed,
        child: Text(
          text,
          style: FABStyles.appStyleButtonText(textColor ?? Colors.white),
        ),
      ),
    );
  }

  // top bar with title and back button
  static AppBar appTopBar(
    String title, {
    bool hasCancel = false,
    Function()? backAction,
    String? rightBtnTitle,
    Function()? rightBtnAction,
  }) {
    return AppBar(
        backgroundColor: Colors.white,
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
                  'Cancel',
                  style: TextStyle(
                      color: primaryLabelColor,
                      fontFamily: themeFont,
                      fontSize: 15.sp),
                ),
              )
            : BackButton(onPressed: backAction),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: headerTextColor,
              fontFamily: themeFont,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp),
        ),
        actions: (rightBtnTitle == null)
            ? null
            : <Widget>[
                TextButton(
                  child: Text(rightBtnTitle),
                  onPressed: rightBtnAction,
                ),
              ]);
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
      textStyle: TextStyle(color: errorRed, fontSize: 32.sp),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4.r))));

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
      maxLength: (keyboardType == TextInputType.phone) ? 9 : null,
      onChanged: onChange,
      style: FABStyles.textFieldTextStyle(Colors.black),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: borderColor ?? textFieldBorderColor)),
          border: const OutlineInputBorder(),
          filled: true,
          counterText: "",
          fillColor: Colors.white,
          prefix: (prefixText == null)
              ? null
              : Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Text(prefixText.isEmpty ? "" : prefixText),
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

  static showAlertDialog(BuildContext context, String title, String okBtnTitle,
      {String? contentStr,
      Function()? okAction,
      String? cancelTitle,
      Function()? cancelAction,
      bool dismissableFromOutside = true}) {
    var actions = [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (okAction != null) {
              okAction();
            }
          },
          child: Text(okBtnTitle))
    ];
    if (cancelTitle != null) {
      actions.insert(
          0,
          TextButton(
              onPressed: cancelAction ?? () => {Navigator.pop(context)},
              child: Text(cancelTitle)));
    }
    showDialog(
        context: context,
        barrierDismissible: dismissableFromOutside,
        builder: (BuildContext context) =>
            (Theme.of(context).platform == TargetPlatform.iOS)
                ? CupertinoAlertDialog(
                    title: Text(title),
                    content: (contentStr == null) ? null : Text(contentStr),
                    actions: actions,
                  )
                : AlertDialog(
                    title: Text(title),
                    content: (contentStr == null) ? null : Text(contentStr),
                    actions: actions,
                  ));
  }
}
