import 'package:crud/app/app.router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

///
import 'package:crud/app/app.locator.dart';

class OtpViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  String otp = '';

  void onChange(value) {
    otp = value;
    notifyListeners();
  }

  void verifyOtp(context,{verificationId, smsCode}) async {
     FocusScope.of(context).unfocus();
    Fluttertoast.showToast(
        msg: 'Wait for while ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        _navigationService.clearStackAndShow(Routes.homeView);
      });
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
