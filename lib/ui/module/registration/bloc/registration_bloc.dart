import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fab_nhl/app/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../app/app_constant.dart';
import '../../../../app/di/locator.dart';
import '../../../router/app_router.dart';

part 'registration_event.dart';
part 'registration_state.dart';

/// responsible for reacting to user interactions in login screen & handling validation and login action
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final bool isMobile;
  RegistrationBloc(this.isMobile) : super(const RegistrationState()) {
    on<ValueUpdated>(_onValueChanged);
    on<NextPressed>(_onNextPressed);
  }

  void _onValueChanged(ValueUpdated event, Emitter<RegistrationState> emit) {
    final value = event.value;
    if (value.isEmpty) {
      emit(RegistrationState(
          value: value, validationStatus: ValidationState.notChecked));
    } else if (isMobile && Validator.isValidMobile(value)) {
      emit(RegistrationState(
          value: value, validationStatus: ValidationState.valid));
    } else if (!isMobile && Validator.isValidEmail(value)) {
      emit(RegistrationState(
          value: value, validationStatus: ValidationState.valid));
    } else {
      emit(RegistrationState(
          value: value, validationStatus: ValidationState.invalid));
    }
  }

  void _onNextPressed(NextPressed event, Emitter<RegistrationState> emit) {
    emit(RegistrationState(
        value: state.value, validationStatus: state.validationStatus));
    final value = state.value.toString().replaceAll(' ', '');
    emit(RegistrationState(
        value: state.value,
        validationStatus: state.validationStatus,
        registrationStatus: value == (isMobile ? '555555555' : 'test@test.com')
            ? ValidationState.valid
            : ValidationState.invalid));
  }

  Function()? nextStep(BuildContext context, RegistrationState state) {
    if (state.registrationStatus == ValidationState.invalid) {
      return null;
    }
    switch (state.validationStatus) {
      case ValidationState.notChecked:
      case ValidationState.invalid:
        return null;
      case ValidationState.valid:
        return () {
          FocusManager.instance.primaryFocus?.unfocus();
          add(const NextPressed());
        };
    }
  }

  navigateToNextScreen(bool isForgotPinFlow) {
    if (isForgotPinFlow) {
      locator<AppRouter>().showVerificationForgotPin([
        isMobile,
        isMobile ? uaeCode + " " + state.value.toString() : state.value
      ]);
    } else {
      locator<AppRouter>().showVerificationScreen([
        isMobile,
        isMobile ? uaeCode + " " + state.value.toString() : state.value
      ]);
    }
  }
}
