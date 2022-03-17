part of 'registration_bloc.dart';

/// events for notifying bloc regarding user actions on registration screen
@immutable
abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
  @override
  List<Object?> get props => [];
}

/// notifies bloc that value is changed
class ValueUpdated extends RegistrationEvent {
  const ValueUpdated(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

/// notifies bloc that next button is pressed
class NextPressed extends RegistrationEvent {
  const NextPressed();
}
