import 'package:cloud_firestore/cloud_firestore.dart';

// this will help to convert json file into object by fecthing if from the database

class Modules {
  String id;
  String tiltle;
  String description;
  Timestamp time;
  String userid;

  Modules(
      {required this.id,
      required this.tiltle,
      required this.description,
      required this.time,
      required this.userid});
  factory Modules.fromJson(DocumentSnapshot snapshot) {
    return Modules(
        id: snapshot.id,
        tiltle: snapshot['title'],
        description: snapshot['description'],
        time: snapshot['time'],
        userid: snapshot['userid']);
  }
}






