import 'package:crud/ui/common/app_colors.dart';
import 'package:crud/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';

import 'otp_viewmodel.dart';

class OtpView extends StackedView<OtpViewModel> {
  final String id;
  const OtpView({required this.id, Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OtpViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: bgLight,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Verify your phone',
                        style: TextStyle(fontSize: 21))),
                verticalSpaceLarge,
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Enter code',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF674EA4)))),
                verticalSpaceTiny,
                Pinput(
                  length: 6,
                  onChanged: viewModel.onChange,
                ),
                verticalSpaceMedium,
                ElevatedButton(
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0),
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF674EA4))),
                    onPressed: () {
                      if (viewModel.otp.length == 6) {
                        viewModel.verifyOtp(
                            verificationId: id, smsCode: viewModel.otp);
                      }
                    },
                    child: const Text(
                      'VERIFY',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ));
  }

  @override
  OtpViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OtpViewModel();
}
