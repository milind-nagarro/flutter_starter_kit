part of 'verification_bloc.dart';

/// events for notifying bloc regarding user actions on registration screen
@immutable
abstract class VerificationEvent extends Equatable {
  const VerificationEvent();
  @override
  List<Object?> get props => [];
}

/// notifies bloc that value is changed
class ValueUpdated extends VerificationEvent {
  const ValueUpdated(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

/// notifies bloc that next button is pressed
class NextPressed extends VerificationEvent {
  const NextPressed();
}

/// notifies bloc that time is expired
class TimeExpireEvent extends VerificationEvent {
  const TimeExpireEvent();
}

/// notifies bloc resend otp is pressed
class ResendEvent extends VerificationEvent {
  const ResendEvent();
}
