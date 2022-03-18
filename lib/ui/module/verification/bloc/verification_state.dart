part of 'verification_bloc.dart';

/// Maintains states for registration screen
@immutable
class VerificationState extends Equatable {
  const VerificationState(
      {this.value,
      this.validationStatus = ValidationState.notChecked,
      this.serverValidationStatus = ValidationState.notChecked,
      this.timeExpired = false});
  // to store phone number entered by user
  final String? value;
  // to store local validation on input
  final ValidationState validationStatus;
  // to store server validation
  final ValidationState serverValidationStatus;
  // to store time expire
  final bool timeExpired;

  @override
  List<Object?> get props =>
      [value, validationStatus, serverValidationStatus, timeExpired];
}
