// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, unused_local_variable, avoid_print, use_build_context_synchronously, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/services/authservice.dart';
import 'package:firebase_login/sreens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

bool loading = false;

class _MyRegisterState extends State<MyRegister> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Register'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              TextField(
                obscureText: true,
                controller: _confirmpassword,
                decoration: const InputDecoration(
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              loading
                  ? CircularProgressIndicator()
                  : Container(
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
                          setState(() {
                            loading = true;
                          });
                          if (_email.text == '' || _password.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('All fields are required'),
                              backgroundColor: Colors.red,
                            ));
                          } else if (_password.text != _confirmpassword.text) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Password Mismatch'),
                                backgroundColor: Colors.red));
                          } else {
                            User? result = await AuthServic()
                                .Register(_email.text, _password.text, context);
                            if (result != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyLogin()));
                            }
                          }
                          setState(() {
                            loading = false;
                          });
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        // loading =false;
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyLogin()));
                },
                child: Text('Already have an account? Login here'),
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(),
              const SizedBox(
                height: 20,
              ),
              SignInButton(Buttons.Google, text: 'SignUp with Google',
                  onPressed: () async {
                await AuthServic().signInGoogle(context);
                // if (result != null) {
                //  print('success');
                // }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
