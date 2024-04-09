// ignore_for_file: unused_import

import 'package:firebase_login/services/authservice.dart';
import 'package:firebase_login/sreens/homepage.dart';
import 'package:firebase_login/sreens/registration.dart';
import 'package:firebase_login/sreens/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: AuthServic().firebaseAuth.authStateChanges(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return HomePage(snapshot.data);
            //return const UploadPage();
          } else {
            return const MyRegister();
          }
        },
      ),
    );
  }
}
