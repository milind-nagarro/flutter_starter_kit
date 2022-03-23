import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'verifypin_state.dart';

class VerifypinCubit extends Cubit<VerifypinInitial> {
  VerifypinCubit() : super(const VerifypinInitial());
  pinUpdated(String pin) {
    final value = pin;
    if (value.length < 6) {
      emit(VerifypinInitial(pin: pin, isValid: false));
    } else {
      emit(VerifypinInitial(pin: pin, isValid: true));
    }
  }

  verifyPin() {
    if (state.pin == "123456") {
      nextScreen();
      emit(VerifypinInitial(pin: state.pin, isValid: true, isVerified: true));
    } else {
      emit(VerifypinInitial(pin: state.pin, isValid: true, isVerified: false));
    }
  }

  nextScreen() {}
}
