import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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


  void verifyNumber(phoneNumber, context) async {
    FocusScope.of(context).unfocus();
    Fluttertoast.showToast(
        msg: 'Wait for while ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
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
    notifyListeners();
  }
}
