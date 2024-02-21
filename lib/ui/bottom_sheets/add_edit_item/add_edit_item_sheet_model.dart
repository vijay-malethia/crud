import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:stacked/stacked.dart';

///
import 'package:crud/app/app.locator.dart';
import 'package:crud/services/databasemethods_service.dart';
import 'package:crud/ui/views/home/home_view.form.dart';

class AddEditItemSheetModel extends BaseViewModel with $HomeView {
  final DatabasemethodsService _databasemethodsService =
      locator<DatabasemethodsService>();
  String? id;
  void addItem(context) async {
    FocusScope.of(context).unfocus();
    Fluttertoast.showToast(
        msg: 'Wait for while ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.white,
        fontSize: 16.0);
    setBusy(true);
    id = randomAlphaNumeric(10);
    if (imagePath != null) {
      await uploadImage(id);
    }
    Map<String, dynamic> itemMap = {
      'id': id,
      "title": titleController.text,
      'description': descriptionsController.text,
      'image_url': imageUrl,
    };
    await _databasemethodsService.addItemDetails(itemMap, id!).then((value) {
      setBusy(false);
      Navigator.pop(context);
    });
  }

  void editItem(context, id) async {
    FocusScope.of(context).unfocus();
    Fluttertoast.showToast(
        msg: 'Wait for while ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.white,
        fontSize: 16.0);
    if (imagePath != null) {
      await uploadImage(id);
    }
    Map<String, dynamic> itemMap = {
      'id': id,
      "title": titleController.text,
      'description': descriptionsController.text,
      'image_url': imageUrl,
    };

    await _databasemethodsService.updateItemDetail(id, itemMap).then((value) {
      Navigator.pop(context);
    });
  }

  XFile? imagePath;
  Future<void> pickImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imagePath = pickedFile;
      notifyListeners();
    }
  }

  //Upload image to firebase storage
  String imageUrl = '';
  Future<void> uploadImage(id) async {
    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceDirImage = reference.child('Images');
    Reference referenceToUploadImage = referenceDirImage.child(id);
    try {
      await referenceToUploadImage.putFile(File(imagePath!.path));
      imageUrl = await referenceToUploadImage.getDownloadURL();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
