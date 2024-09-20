import 'dart:io';

import 'package:epicpay/utilities/logger.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class Biometrics {
  static const integrationTestFlag =
      bool.fromEnvironment("IS_INTEGRATION_TEST");

  const Biometrics();

  static Future<bool> get hasBiometrics async {
    final LocalAuthentication localAuth = LocalAuthentication();

    final results = await Future.wait<bool>([
      localAuth.canCheckBiometrics,
      localAuth.isDeviceSupported(),
    ]);

    return results.first && results.last;
  }

  Future<bool> authenticate({
    required String cancelButtonText,
    required String localizedReason,
    required String title,
  }) async {
    if (!(Platform.isIOS || Platform.isAndroid)) {
      Logging.instance.log(
          "Tried to use Biometrics.authenticate() on a platform that is not Android or iOS! ...returning false.",
          level: LogLevel.Error);
      return false;
    }
    if (integrationTestFlag) {
      Logging.instance.log(
          "Tried to use Biometrics.authenticate() during integration testing. Returning false.",
          level: LogLevel.Warning);
      return false;
    }

    final LocalAuthentication localAuth = LocalAuthentication();

    final canCheckBiometrics = await localAuth.canCheckBiometrics;
    final isDeviceSupported = await localAuth.isDeviceSupported();

    // debugPrint("canCheckBiometrics: $canCheckBiometrics");
    // debugPrint("isDeviceSupported: $isDeviceSupported");

    if (canCheckBiometrics && isDeviceSupported) {
      List<BiometricType> availableSystems =
          await localAuth.getAvailableBiometrics();

      Logging.instance.log(
        "Bio availableSystems: $availableSystems",
        level: LogLevel.Info,
      );

      //TODO properly handle caught exceptions
      try {
        final bool didAuthenticate = await localAuth.authenticate(
          localizedReason: localizedReason,
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
          authMessages: <AuthMessages>[
            AndroidAuthMessages(
              biometricHint: "",
              cancelButton: cancelButtonText,
              signInTitle: title,
            ),
          ],
        );

        if (didAuthenticate) {
          return true;
        }
      } catch (e) {
        Logging.instance.log(
          "local_auth exception caught in Biometrics.authenticate(), e: $e",
          level: LogLevel.Error,
        );
      }
    }

    // authentication failed
    return false;
  }
}
