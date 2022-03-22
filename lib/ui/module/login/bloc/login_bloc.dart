import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fab_nhl/app/app_constant.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

/// responsible for reacting to user interactions in login screen & handling validation and login action
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginPhoneNumberChanged>(_onPhoneNumberChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onPhoneNumberChanged(
      LoginPhoneNumberChanged event, Emitter<LoginState> emit) {
    final value = event.phoneNumber;
    if (value.isEmpty) {
      emit(LoginState(
          phoneNumber: value, validationStatus: ValidationState.invalid));
    } else {
      emit(LoginState(
          phoneNumber: value, validationStatus: ValidationState.valid));
    }
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) {
    emit(LoginState(
        phoneNumber: state.phoneNumber,
        validationStatus: state.validationStatus,
        loginStatus: LoginStates.checking));
    final value = state.phoneNumber;
    emit(LoginState(
        phoneNumber: state.phoneNumber,
        validationStatus: state.validationStatus,
        loginStatus: value == '555555555'
            ? LoginStates.authenticated
            : LoginStates.unauthenticated));
  }
}
