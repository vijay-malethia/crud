import 'package:crud/services/databasemethods_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

///
import 'package:crud/app/app.bottomsheets.dart';
import 'package:crud/app/app.locator.dart';

class HomeViewModel extends BaseViewModel {
  Stream? itemStream;
  final _bottomService = locator<BottomSheetService>();
  final DatabasemethodsService _databasemethodsService =
      locator<DatabasemethodsService>();

  void addEditItem({title, id, imageurl}) async {
    await _bottomService.showCustomSheet(
        isScrollControlled: true,
        variant: BottomSheetType.addEditItem,
        title: title,
        description: imageurl,
        data: id);
  }

  //Get all items
  void getItems() async {
    itemStream = await _databasemethodsService.getAllItems();
    notifyListeners();
  }

  void deleteItem(id) async {
    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceDirImage = reference.child('Images');
    Reference referenceToUploadImage = referenceDirImage.child(id);
    referenceToUploadImage.delete();
    await _databasemethodsService.deleteItem(id);
    notifyListeners();
  }

  HomeViewModel() {
    getItems();
  }
}
