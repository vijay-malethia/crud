import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

///
import 'package:crud/crud_app.dart';
import 'package:crud/app/app.bottomsheets.dart';
import 'package:crud/app/app.dialogs.dart';
import 'package:crud/app/app.locator.dart';

Future<void> main() async {
  //Ensure flutter biniding
  WidgetsFlutterBinding.ensureInitialized();

  //Init firebase
  await Firebase.initializeApp();

  //Init locator, dialog and bottom
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  //Run App
  runApp(const CrudApp());
}
