part of 'setup_confirm_pin_bloc.dart';

@immutable
class SetupConfirmPinState extends Equatable {
  const SetupConfirmPinState(
      {this.pinData, this.validationState = ValidationState.notChecked,
      this.buttonState = ValidationState.notChecked});

  final String? pinData;

  final ValidationState validationState;

  final ValidationState buttonState;

  @override
  List<Object?> get props => [pinData, validationState, buttonState];
}
