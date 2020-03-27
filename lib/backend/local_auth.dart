//Copyright 2020 Joshua Hyunbin Lee, Jaeyong Sung
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.
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
