import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future addInto(
    String title,
    String description,
    String userid,
  ) async {
    //  try {
    firestore.collection('notes').add({
      'title': title,
      'description': description,
      'time': DateTime.now(),
      'userid': userid,
    });
    // } catch (e) {
    //ScaffoldMessenger.of(context)
    //  .showSnackBar(SnackBar(content: Text(e.toString())));
    //}
  }

  // to update the note
  Future update(String docid, String title, String description) async {
    await firestore
        .collection('notes')
        .doc(docid)
        .update({'title': title, 'description': description});
   
  }
}
