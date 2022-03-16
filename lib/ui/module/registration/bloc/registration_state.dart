part of 'registration_bloc.dart';

/// Maintains states for registration screen
@immutable
class RegistrationState extends Equatable {
  const RegistrationState(
      {this.value,
      this.validationStatus = ValidationState.notChecked,
      this.registrationStatus = ValidationState.notChecked});
  // to store phone number entered by user
  final String? value;
  // to store local validation on input
  final ValidationState validationStatus;
  // to store server validation
  final ValidationState registrationStatus;

  @override
  List<Object?> get props => [value, validationStatus, registrationStatus];
}
