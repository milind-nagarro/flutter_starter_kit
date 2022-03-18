import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

  final bool isMobile;

  VerificationBloc(this.isMobile) : super(const VerificationState()) {
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

    emit(VerificationState(
        value: state.value,
        validationStatus: state.validationStatus,
        serverValidationStatus: value == '123456'
            ? ValidationState.valid
            : ValidationState.invalid));
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

  navigateToNextScreen() {
    if (isMobile) {
      locator<AppRouter>().showRegisterEmailScreen(isReplace: true);
    } else {
      locator<AppRouter>().showSetupPin();
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
