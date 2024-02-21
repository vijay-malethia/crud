import 'package:cloud_firestore/cloud_firestore.dart';

class DatabasemethodsService {
  //To store info of item in firebase database
  Future addItemDetails(Map<String, dynamic> itemInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection('Items')
        .doc(id)
        .set(itemInfo);
  }

  //To get all items
  Future<Stream<QuerySnapshot>> getAllItems() async {
    return FirebaseFirestore.instance.collection('Items').snapshots();
  }

  //To update item details
  Future updateItemDetail(id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection('Items')
        .doc(id)
        .update(updateInfo);
  }

  //To delete item
  Future deleteItem(id) async {
    return await FirebaseFirestore.instance
        .collection('Items')
        .doc(id)
        .delete();
  }
}
