import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fab_nhl/app/biometric_authenticator.dart';
import 'package:fab_nhl/app/di/locator.dart';
import 'package:fab_nhl/app/prefs/local_storage.dart';
import 'package:fab_nhl/app/resources/style.dart';
import 'package:fab_nhl/data/remote/response/user_response.dart';
import 'package:fab_nhl/ui/router/app_router.dart';
import 'package:fab_nhl/ui/screen/common_widget/permission_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../../app/app_constant.dart';

part 'verifypin_state.dart';

class VerifypinCubit extends Cubit<VerifypinInitial> {
  VerifypinCubit(this.fromLogin) : super(const VerifypinInitial()) {
    if (!fromLogin) {
      _checkFaceIdPreference();
    }
  }

  _checkFaceIdPreference() async {
    final faceIdPref = await LocalStorage.getFaceidPreference();
    if (faceIdPref) {
      _faceidAuthentication();
    }
  }

  _faceidAuthentication() async {
    try {
      bool isAuthenticated =
          await BioMetricAuthentication.authenticateWithBiometrics();
      if (isAuthenticated) {
        locator<AppRouter>().showDashboard();
      } else {
        debugPrint("isAuthenticated failed");
      }
    } on PlatformException catch (e) {
      // TODO: show alert on widget
      // FABWidget.showAlertDialog(
      //   context,
      //   e.message.toString(),
      //   AppLocalizations.of(context).ok,
      // );
    }
  }

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
    if (state.pin == locator<User>().pin) {
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
