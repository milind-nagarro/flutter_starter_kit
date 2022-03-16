part of 'login_bloc.dart';

/// events for notifying bloc regarding user actions on login screen
@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

/// notifies bloc that phone number is changed
class LoginPhoneNumberChanged extends LoginEvent {
  const LoginPhoneNumberChanged(this.phoneNumber);
  final String phoneNumber;
  @override
  List<Object?> get props => [phoneNumber];
}

/// notifies bloc that login button is pressed
class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
