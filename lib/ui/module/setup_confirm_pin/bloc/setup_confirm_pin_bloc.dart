import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../app/app_constant.dart';

part 'setup_confirm_pin_event.dart';
part 'setup_confirm_pin_state.dart';

/// Handles states for Setup and Confirm PIN screens
class SetupConfirmPinBloc
    extends Bloc<SetupConfirmPinEvent, SetupConfirmPinState> {
  SetupConfirmPinBloc()
      : super(const SetupConfirmPinState(
            validationState: ValidationState.notChecked,
            buttonState: ValidationState.notChecked)) {
    on<SetupPinSubmit>(_setupPinCheck);
    on<ConfirmPinSubmit>(_confirmPinCheck);
    on<PinEntered>(_onPinEntered);
    on<ResetState>(_resetState);
  }

  /// On Submitting PIN on Setup PIN Screen check
  void _setupPinCheck(
      SetupPinSubmit event, Emitter<SetupConfirmPinState> emit) {
    final pinData = event.pinData;

    if (pinData.isEmpty && pinData.length != 4) {
      emit(SetupConfirmPinState(
          pinData: pinData,
          validationState: ValidationState.invalid,
          buttonState: state.buttonState));
    } else {
      emit(SetupConfirmPinState(
          pinData: pinData,
          validationState: ValidationState.valid,
          buttonState: state.buttonState));
    }
  }

  /// On Confirming PIN on Confirm PIN Screen check
  void _confirmPinCheck(
      ConfirmPinSubmit event, Emitter<SetupConfirmPinState> emit) {
    final confirmPinData = event.verifyPinData;
    final existingPinData = event.existingPinData;

    if (confirmPinData == existingPinData) {
      emit(SetupConfirmPinState(
          pinData: confirmPinData,
          validationState: ValidationState.valid,
          buttonState: state.buttonState));
    } else {
      emit(SetupConfirmPinState(
          pinData: confirmPinData,
          validationState: ValidationState.invalid,
          buttonState: state.buttonState));
    }
  }

  /// Handles on change of PIN value and handling Button States
  void _onPinEntered(PinEntered event, Emitter<SetupConfirmPinState> emit) {
    final pinData = event.pinValue;

    if (pinData != null && pinData.length == 4) {
      emit(SetupConfirmPinState(
          pinData: pinData,
          buttonState: ValidationState.valid,
          validationState: state.validationState));
    } else {
      emit(SetupConfirmPinState(
          pinData: pinData,
          buttonState: ValidationState.invalid,
          validationState: state.validationState));
    }
  }

  /// Resets the validationState to [ValidationState.notChecked] on change of entered PIN
  void _resetState(ResetState event, Emitter<SetupConfirmPinState> emit) {
    emit(SetupConfirmPinState(
        pinData: state.pinData,
        validationState: ValidationState.notChecked,
        buttonState: state.buttonState));
  }
}
