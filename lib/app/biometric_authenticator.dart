import 'package:local_auth/local_auth.dart';

class BioMetricAuthentication {
  static final LocalAuthentication localAuthentication = LocalAuthentication();

  static Future<bool> authenticateWithBiometrics() async {
    bool isAuthenticated = false;
    if (await isBiometricAvailable()) {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'Please complete the biometrics to proceed.',
        biometricOnly: true,
      );
    }
    return isAuthenticated;
  }

  static Future<bool> isBiometricAvailable() async {
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    return isBiometricSupported && canCheckBiometrics;
  }
}
