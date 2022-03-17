part of 'login_bloc.dart';

/// Maintains states for login screen
@immutable
class LoginState extends Equatable {
  const LoginState(
      {this.phoneNumber,
      this.validationStatus = ValidationState.notChecked,
      this.loginStatus = LoginStates.notChecked});
  // to store phone number entered by user
  final String? phoneNumber;
  // to store validation on input
  final ValidationState validationStatus;
  // to store login state after api request
  final LoginStates loginStatus;
  @override
  List<Object?> get props => [phoneNumber, validationStatus, loginStatus];
}
