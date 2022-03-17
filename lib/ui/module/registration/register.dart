import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/app_constant.dart';
import '../../../app/resources/assets.dart';
import '../../../app/resources/colors.dart';
import '../../../app/resources/style.dart';
import 'bloc/registration_bloc.dart';

/// widget to create register mobile and email screen
/// pass constructor 'true' registering for mobile,'false' for email
class Register extends StatelessWidget {
  const Register(this.isMobile);
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    RegistrationBloc registrationBloc = RegistrationBloc();

    return Scaffold(
        appBar: FABWidget.appTopBar(AppLocalizations.of(context).register),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
            child: BlocProvider(
              create: (BuildContext context) {
                return registrationBloc;
              },
              child: BlocConsumer<RegistrationBloc, RegistrationState>(
                  builder: (context, state) {
                return Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          isMobile
                              ? AppLocalizations.of(context).enter_mobile
                              : AppLocalizations.of(context).enter_email,
                          style: FABStyles.appStyleHeaderText(header)),
                      SizedBox(height: 8.h),
                      Text(
                          isMobile
                              ? AppLocalizations.of(context).enter_mobile_adha
                              : AppLocalizations.of(context).enter_email_valid,
                          style: FABStyles.subHeaderLabelStyle),
                      SizedBox(height: 23.h),
                      TextField(
                        keyboardType: isMobile
                            ? TextInputType.phone
                            : TextInputType.emailAddress,
                        onChanged: (text) {
                          registrationBloc.add(ValueUpdated(text));
                        },
                        style: FABStyles.appStyleInputText,
                        decoration: InputDecoration(
                            filled: false,
                            prefixText: isMobile ? uaeCode : null,
                            labelText: isMobile
                                ? AppLocalizations.of(context).mobile_number
                                : AppLocalizations.of(context).email,
                            errorText: (state.registrationStatus ==
                                    ValidationState.invalid)
                                ? AppLocalizations.of(context).not_registered
                                : null,
                            suffixIcon: (state.registrationStatus ==
                                    ValidationState.invalid)
                                ? Image.asset(errorIconTextField)
                                : null,
                            errorMaxLines: 2),
                      ),
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
                        onPressed: registrationBloc.nextStep(context, state),
                      ),
                    ),
                  )),
                ]);
              }, listener: (context, state) {
                if (state.registrationStatus == ValidationState.valid) {
                  registrationBloc.navigateToNextScreen();
                }
              }),
            ),
          ),
        ));
  }
}
