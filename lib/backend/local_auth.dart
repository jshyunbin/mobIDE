import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  final LocalAuthentication _localAuth;

  LocalAuth() : _localAuth = LocalAuthentication();

  Future<bool> check(String reason,
      {Function() onNotAvailable,
      Function() onPasscodeNotSet,
      Function() onNotEnrolled,
      Function() onOtherOperatingSystem,
      Function() onLockedOut,
      Function() onPermanentlyLockedOut}) async {
    bool res;
    try {
      res = await _localAuth.authenticateWithBiometrics(
          localizedReason: reason, stickyAuth: true, useErrorDialogs: false);
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        onNotAvailable();
      } else if (e.code == auth_error.passcodeNotSet) {
        onPasscodeNotSet();
      } else if (e.code == auth_error.notEnrolled) {
        onNotEnrolled();
      } else if (e.code == auth_error.otherOperatingSystem) {
        onOtherOperatingSystem();
      } else if (e.code == auth_error.lockedOut) {
        onLockedOut();
      } else if (e.code == auth_error.permanentlyLockedOut) {
        onPermanentlyLockedOut();
      }
      return false;
    }
    return res;
  }

  void cancel() {
    _localAuth.stopAuthentication();
  }
}

final auth = LocalAuth();
