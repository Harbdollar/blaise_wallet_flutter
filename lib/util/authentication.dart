import 'dart:io';
import 'package:local_auth/local_auth.dart';

class AuthUtil {
  ///
  /// hasBiometrics()
  /// 
  /// @returns [true] if device has fingerprint/faceID available and registered, [false] otherwise
  Future<bool> hasBiometrics() async {
    LocalAuthentication localAuth = new LocalAuthentication();
    bool canCheck = await localAuth.canCheckBiometrics;
    if (canCheck) {
      List<BiometricType> availableBiometrics = await localAuth.getAvailableBiometrics();
      if (Platform.isIOS && availableBiometrics.contains(BiometricType.face)) {
        return true;
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        return true;
      }
    }
    return false;
  }

  ///
  /// authenticateWithBiometrics()
  /// 
  /// @param [message] Message shown to user in FaceID/TouchID popup
  /// @returns [true] if successfully authenticated, [false] otherwise
  Future<bool> authenticateWithBiometrics(String message) async {
    bool hasBiometricsEnrolled = await hasBiometrics();
    if (hasBiometricsEnrolled) {
      LocalAuthentication localAuth = new LocalAuthentication();
      return await localAuth.authenticateWithBiometrics(
        localizedReason: message,
        useErrorDialogs: false
      );
    }
    return false;
  }

  ///
  /// authenticate() - Authenticate with either PIN or Biometrics depending on nwhat's available
  /// 
  /// @param [message] Message shown to user in FaceID/TouchID popup
  /// @returns [true] if successfully authenticated, [false] otherwise
  Future<bool> authenticate(String message) async {
    if (await hasBiometrics()) {
      return await authenticateWithBiometrics(message);
    } else {
      // TODO - PIN screen
      return false;
    }
  }
}