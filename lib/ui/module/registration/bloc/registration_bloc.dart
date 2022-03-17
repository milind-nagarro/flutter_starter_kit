import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
  RegistrationBloc() : super(const RegistrationState()) {
    on<ValueUpdated>(_onPhoneNumberChanged);
    on<NextPressed>(_onLoginSubmitted);
  }

  void _onPhoneNumberChanged(
      ValueUpdated event, Emitter<RegistrationState> emit) {
    final value = event.value;
    if (value.isEmpty) {
      emit(RegistrationState(
          value: value, validationStatus: ValidationState.invalid));
    } else {
      emit(RegistrationState(
          value: value, validationStatus: ValidationState.valid));
    }
  }

  void _onLoginSubmitted(NextPressed event, Emitter<RegistrationState> emit) {
    emit(RegistrationState(
        value: state.value, validationStatus: state.validationStatus));
    final value = state.value;
    emit(RegistrationState(
        value: state.value,
        validationStatus: state.validationStatus,
        registrationStatus: value == '555555555'
            ? ValidationState.valid
            : ValidationState.invalid));
  }

  Function()? nextStep(BuildContext context, RegistrationState state) {
    if (state.registrationStatus == ValidationState.invalid) {
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
    locator<AppRouter>().showRegisterEmailScreen();
  }
}
