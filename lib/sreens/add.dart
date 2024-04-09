// ignore_for_file: prefer_const_constructors, deprecated_member_use, sized_box_for_whitespace, must_be_immutable

//import 'package:firebase_login/services/authservice.dart';
//import 'package:firebase_login/sreens/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/services/firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  User user;
  AddPage(this.user, {super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController titles = TextEditingController();
  TextEditingController describe = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.delete))],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100, right: 25, left: 25),
            child: Container(
              //height: 800,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: titles,
                      decoration: InputDecoration(
                          hintText: 'title',
                          // label: Text('Title'),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: describe,
                      minLines: 5,
                      maxLines: 15,
                      decoration: InputDecoration(
                          hintText: 'describe',
                          //labelText: 'Description',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (titles.text == '' || describe.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('all field required')));
                            } else {
                              await FirestoreService().addInto(
                                titles.text,
                                describe.text,
                                widget.user.uid,
                              );
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
