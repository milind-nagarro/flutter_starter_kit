part of 'setup_confirm_pin_bloc.dart';

@immutable
abstract class SetupConfirmPinEvent extends Equatable {
  const SetupConfirmPinEvent();
  @override
  List<Object> get props => [];
}

/// On Submitting Setup PIN value
class SetupPinSubmit extends SetupConfirmPinEvent {
  const SetupPinSubmit({required this.pinData});
  final String pinData;

  @override
  List<Object> get props => [pinData];
}

/// On Submitting Confirm PIN value
class ConfirmPinSubmit extends SetupConfirmPinEvent {
  const ConfirmPinSubmit({required this.verifyPinData, required this.existingPinData});
  final String verifyPinData;
  final String? existingPinData;

  @override
  List<Object> get props => [verifyPinData, existingPinData!];
}

/// Resetting the state on change of the PIN value
class ResetState extends SetupConfirmPinEvent {
  const ResetState();
}

/// Changing the button state on change of PIN value
class PinEntered extends SetupConfirmPinEvent {
  const PinEntered({required this.pinValue});
  final String? pinValue;

  @override
  List<Object> get props => [pinValue!];
}