import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fab_nhl/app/prefs/local_storage.dart';
import 'package:fab_nhl/data/remote/response/user_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../../../app/app_constant.dart';
import '../../../../app/di/locator.dart';
import '../../../router/app_router.dart';

part 'verification_event.dart';
part 'verification_state.dart';

/// responsible for reacting to user interactions in login screen & handling validation and login action
class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final CountdownController countdownController =
      CountdownController(autoStart: true);
  TextEditingController textController = TextEditingController();
  final String? emailOrNumber;
  final bool isMobile;
  final bool isLogin;
  late final User? loggedUser;
  VerificationBloc(this.isMobile, this.emailOrNumber, {this.isLogin = false})
      : super(const VerificationState()) {
    on<ValueUpdated>(_onValueChanged);
    on<NextPressed>(_onNextPressed);
    on<TimeExpireEvent>(_onTimeExpire);
    on<ResendEvent>(_onResend);
  }

  void _onValueChanged(ValueUpdated event, Emitter<VerificationState> emit) {
    final value = event.value;
    if (value.length < 6) {
      emit(VerificationState(
          value: value, validationStatus: ValidationState.invalid));
    } else {
      emit(VerificationState(
          value: value, validationStatus: ValidationState.valid));
    }
  }

  void resetTimer() {
    textController.clear();
    countdownController.restart();
  }

  void _onNextPressed(NextPressed event, Emitter<VerificationState> emit) {
    emit(VerificationState(
        value: state.value, validationStatus: state.validationStatus));
    final value = state.value;

    final verified = (value == '123456');
    if (isLogin && verified && emailOrNumber != null) {
      // these values (user model) will be returned from api response
      var map = <String, String>{};
      map['id'] = '123123123';
      map['name'] = 'Husain';
      map['phNumber'] = '+971$emailOrNumber';
      map['pin'] = '123456';
      final jsonStr = jsonEncode(map);
      loggedUser = User.fromJson(map);
      locator.registerLazySingleton(() => loggedUser!);
      LocalStorage.storeUserInfo(jsonStr);
    }
    emit(VerificationState(
        value: state.value,
        validationStatus: state.validationStatus,
        serverValidationStatus:
            verified ? ValidationState.valid : ValidationState.invalid));
  }

  void _onTimeExpire(TimeExpireEvent event, Emitter<VerificationState> emit) {
    emit(VerificationState(
        value: state.value,
        validationStatus: ValidationState.invalid,
        serverValidationStatus: ValidationState.notChecked,
        timeExpired: true));
  }

  void _onResend(ResendEvent event, Emitter<VerificationState> emit) {
    resetTimer();
    emit(const VerificationState(
        value: "",
        validationStatus: ValidationState.notChecked,
        serverValidationStatus: ValidationState.notChecked,
        timeExpired: false));
  }

  Function()? nextStep(BuildContext context, VerificationState state) {
    if (state.serverValidationStatus == ValidationState.invalid) {
      return null;
    }
    if (state.timeExpired) {
      return null;
    }
    switch (state.validationStatus) {
      case ValidationState.invalid:
        return null;
      case ValidationState.valid:
        return () {
          FocusManager.instance.primaryFocus?.unfocus();
          add(const NextPressed());
        };
      case ValidationState.notChecked:
        return null;
    }
  }

  navigateToNextScreen(bool isForgotPinFlow) {
    if (!isForgotPinFlow) {
      if (isMobile) {
        if (isLogin) {
          locator<AppRouter>().showVerifyPin(fromLogin: true);
        } else {
          locator<AppRouter>().showRegisterEmailScreen(isReplace: true);
        }
      } else {
        locator<AppRouter>().showSetupPin();
      }
    } else {
      locator<AppRouter>().showSetupPinForgotPin();
    }
  }

  String formatedTime(int secTime) {
    String getParsedTime(String time) {
      if (time.length <= 1) return "0$time";
      return time;
    }

    int min = secTime ~/ 60;
    int sec = (secTime % 60);

    String parsedTime =
        "$min minute " + getParsedTime(sec.toString()) + " seconds";

    return parsedTime;
  }
}
