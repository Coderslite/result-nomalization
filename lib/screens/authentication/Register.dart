// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onah_project/constants/constants.dart';
import 'package:onah_project/screens/authentication/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../QuestionPage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  "Fill the form below with your right credentials",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      hintText: "Email", border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: "Name", border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "Password", border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 600,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: blue),
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) => FirebaseFirestore.instance
                                    .collection("Users")
                                    .add({
                                  "email": emailController.text,
                                  "password": passwordController.text,
                                  "role": "User",
                                  "createdAt": Timestamp.now(),
                                }))
                            .then((value) async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString('role', 'User');
                          setState(() {
                            isLoading = false;
                          });
                          Fluttertoast.showToast(
                              msg: 'Registration Successful');

                          print("registration successful");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const QuestionPage();
                          }));
                        }).catchError((err) {
                          setState(() {
                            isLoading = false;
                          });
                          print(err);
                          Fluttertoast.showToast(msg: '$err');
                        }).catchError((err) {
                          Fluttertoast.showToast(msg: '$err');

                          setState(() {
                            isLoading = false;
                          });
                          print(err);
                        });
                      },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: white,
                            )
                          : const Text("Register")),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                    text: "Already have an account ?  ",
                    children: [
                      TextSpan(
                        text: "Login",
                        style: TextStyle(color: blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return const LoginScreen();
                            }));
                          },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
