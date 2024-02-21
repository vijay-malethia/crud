import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

///
import 'package:crud/app/app.locator.dart';
import 'package:crud/app/app.router.dart';
import 'package:crud/ui/views/auth/auth_view.form.dart';

class AuthViewModel extends BaseViewModel with $AuthView {
  final _navigationService = locator<NavigationService>();
  FirebaseAuth auth = FirebaseAuth.instance;

  void verifyNumber(phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        debugPrint(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        _navigationService.navigateToOtpView(id: verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
