import 'package:fab_nhl/app/app_constant.dart';
import 'package:fab_nhl/app/resources/colors.dart';
import 'package:fab_nhl/app/resources/style.dart';
import 'package:fab_nhl/ui/module/verification/bloc/verification_bloc.dart';
import 'package:fab_nhl/ui/screen/common_widget/pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timer_count_down/timer_count_down.dart';

/// widget to create verification screen
/// pass constructor 'true' registering for mobile,'false' for email
class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: FABWidget.appTopBar(AppLocalizations.of(context).dashboard),
        backgroundColor: appBGColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
            child: Container(

            ),
          ),
        ));
  }
}
