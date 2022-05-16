// import 'package:biometric_auth/biometric_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
// import 'package:local_auth/local_auth.dart';
import 'package:sf_biomatric_auth/common/common_widget.dart';
import 'package:sf_biomatric_auth/services/method_channel_service.dart';

// import 'package:biometricx/biometricx.dart' as biometricxAs;

class BioMatricAuth extends StatefulWidget {
  @override
  _BioMatricAuthState createState() => _BioMatricAuthState();
}

class _BioMatricAuthState extends State<BioMatricAuth> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BioMatricButton(
          buttonTitle: 'Check availability',
          onClick: () async {
            // checkBioMatricSupportedInDevice();
            bool isBioMatricAvailable = await MethodChannelService().isBioMatricAvailable();
            _showAlert(context, 'Device Biomatric availability', isBioMatricAvailable ? 'It\'s available' : 'It\'s not available');
          },
        ),
        BioMatricButton(
          buttonTitle: 'Check biometric type',
          onClick: () async {

            String deviceBioMatricType = await MethodChannelService().getDeviceBioMatricType();
            _showAlert(context, 'Device Biomatric Type', deviceBioMatricType);
          },
        ),
      ],
    );
  }
}

extension _ on _BioMatricAuthState {

  void _showAlert(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }


  ///local_auth
  Future<bool> checkBioMatricSupportedInDevice() async {
    final LocalAuthentication auth = LocalAuthentication();

    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate = await auth.isDeviceSupported();

    print('canAuthenticateWithBiometrics: $canAuthenticateWithBiometrics >>>> >>>> >>>> >>>> >>>> >>>> >>>> >>>> ');
    print('canAuthenticate: $canAuthenticate >>>> >>>> >>>> >>>> >>>> >>>> >>>> >>>> ');


    final List<BiometricType> availableBiometrics =
    await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }

    return false;
  }

  ///biometric_auth
  // Future<bool> biometric_auth() async {
  //   var biometric = BiometricWidget.of(context);
  //   bool hasFingerPrintSupport = biometric.hasFingerPrintSupport;
  //   String authorizedOrNot = biometric.authorizedOrNot;
  //   var availableBiometricType = biometric.availableBiometricType;
  //
  //   return false;
  // }
}
