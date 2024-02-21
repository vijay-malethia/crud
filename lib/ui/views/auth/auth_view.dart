import 'package:crud/ui/common/app_colors.dart';
import 'package:crud/ui/views/auth/auth_view.form.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'auth_viewmodel.dart';
import 'package:crud/ui/common/ui_helpers.dart';

@FormView(fields: [FormTextField(name: 'phoneNumber')])
class AuthView extends StackedView<AuthViewModel> with $AuthView {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: bgLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Continue with Phone',
                      style: TextStyle(fontSize: 21))),
              verticalSpaceLarge,
              renderTextField(viewModel),
              verticalSpaceLarge,
              ElevatedButton(
                  style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll(0),
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFF674EA4))),
                  onPressed: () =>
                      viewModel.verifyNumber(phoneNumberController.text),
                  child: viewModel.isBusy
                      ? const CircularProgressIndicator()
                      : const Text(
                          'CONTINUE',
                          style: TextStyle(color: Colors.white),
                        ))
            ],
          ),
        ),
      ),
    );
  }

  TextFormField renderTextField(AuthViewModel viewModel) {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 10,
      controller: phoneNumberController,
      decoration: InputDecoration(
        counterText: '',
        labelText: "Moble Number",
        prefixIcon: const Icon(Icons.call),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  AuthViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AuthViewModel();
}
