// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, use_build_context_synchronously, dead_code

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/services/authservice.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  //bool loading = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Login'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 90, left: 30, right: 30),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: true,
              controller: _password,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green, // foreground
                ),
                onPressed: () async {
                  if (_email.text == '' || _password.text == '') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('All fields are required'),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    User? result = await AuthServic()
                        .Login(_email.text, _password.text, context);
                    if (result != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(result)));
                    }
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
