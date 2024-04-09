// ignore_for_file: prefer_const_constructors, deprecated_member_use, sized_box_for_whitespace, must_be_immutable

//import 'package:firebase_login/services/authservice.dart';
//import 'package:firebase_login/sreens/registration.dart';
import 'package:firebase_login/services/firestore.dart';
import 'package:firebase_login/services/modules.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  Modules note;

  EditPage(this.note, {super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController title = TextEditingController();
  TextEditingController desp = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    title.text = widget.note.tiltle;
    desp.text = widget.note.description;
    super.initState();
  }

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
                      controller: title,
                      decoration: InputDecoration(
                          hintText: title.text,
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
                      controller: desp,
                      minLines: 5,
                      maxLines: 15,
                      decoration: InputDecoration(
                          hintText: desp.text,
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
                          onPressed: ()async {
                             await FirestoreService().update(widget.note.id, title.text, desp.text);
                          },
                          child: Text(
                            'Update Notes',
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
