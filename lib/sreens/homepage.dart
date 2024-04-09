// ignore_for_file: prefer_const_constructors, deprecated_member_use, sized_box_for_whitespace, must_be_immutable, non_constant_identifier_names, unused_local_variable, dead_code
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/services/authservice.dart';
import 'package:firebase_login/services/modules.dart';
import 'package:firebase_login/sreens/edit.dart';
//import 'package:firebase_login/sreens/edit.dart';
//import 'package:firebase_login/sreens/edit.dart';
import 'package:firebase_login/sreens/registration.dart';
import 'package:firebase_login/sreens/upload_image.dart';
import 'package:flutter/material.dart';

import 'add.dart';

class HomePage extends StatelessWidget {
  User user;
  HomePage(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UploadPage()));
              },
              child: Text('Upload Page')),
          TextButton.icon(
            onPressed: () async {
              await AuthServic().Logout();
              // ignore: use_build_context_synchronously
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyRegister()));
            },
            icon: Icon(Icons.logout),
            label: Text('Log Out'),
            style: TextButton.styleFrom(primary: Colors.white),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPage(user)));
        },
        child: Text('ADD'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('notes')
              .where('userid', isEqualTo: user.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length > 0) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      // final data = snapshot.data[index];
                      Modules notes =
                          Modules.fromJson(snapshot.data.docs[index]);
                      return Card(
                        color: Colors.teal,
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          title: Text(
                            notes.tiltle,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            notes.description,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => EditPage(notes))),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: Text('No Notes Available'),
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
