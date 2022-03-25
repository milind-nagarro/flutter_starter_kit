import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fab_nhl/app/di/locator.dart';
import 'package:fab_nhl/data/remote/response/user_response.dart';
import 'package:fab_nhl/ui/router/app_router.dart';
import 'package:fab_nhl/ui/screen/common_widget/permission_screen.dart';

import '../../../../app/app_constant.dart';

part 'verifypin_state.dart';

class VerifypinCubit extends Cubit<VerifypinInitial> {
  VerifypinCubit(this.fromLogin) : super(const VerifypinInitial());
  var maxTries = 3;
  final bool fromLogin;
  pinUpdated(String pin) {
    final value = pin;
    if (value.length < 6) {
      emit(VerifypinInitial(pin: pin, isValid: ValidationState.notChecked));
    } else {
      emit(VerifypinInitial(pin: pin, isValid: ValidationState.valid));
    }
  }

  verifyPin() {
    if (state.pin == "123456") {
      nextScreen();
      emit(VerifypinInitial(
          pin: state.pin, isValid: ValidationState.valid, isVerified: true));
    } else {
      if (maxTries == 0) {
        emit(VerifypinInitial(
            pin: state.pin,
            isValid: ValidationState.invalid,
            isVerified: false,
            maxRetriesAttempted: true));
        return;
      }

      maxTries--;
      emit(VerifypinInitial(
          pin: state.pin, isValid: ValidationState.invalid, isVerified: false));
    }
  }

  nextScreen() {
    if (fromLogin) {
      locator<AppRouter>().showPermissionScreen(PermissionType.location);
    } else {
      locator<AppRouter>().showDashboard();
    }
  }

  Function()? nextStep() {
    print("state ${state.isValid}");
    if (state.isValid == ValidationState.valid) {
      if (state.isVerified == false) {
        return null;
      } else {
        return () => {verifyPin()};
      }
    } else {
      return null;
    }
  }
}
