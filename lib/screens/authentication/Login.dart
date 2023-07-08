// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onah_project/constants/constants.dart';
import 'package:onah_project/screens/HomeRoot.dart';
import 'package:onah_project/screens/QuestionPage.dart';
import 'package:onah_project/screens/authentication/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
                  "Login",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  "Please provide your right credentials to proceed",
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
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) {
                          FirebaseFirestore.instance
                              .collection("Users")
                              .where('email', isEqualTo: emailController.text)
                              .get()
                              .then((value) async {
                            setState(() {
                              isLoading = false;
                            });
                            var data = value.docs.first.data();
                            var prefs = await SharedPreferences.getInstance();
                            if (data['role'] == 'User') {
                              prefs.setString('role', 'User');
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const QuestionPage();
                              }));
                            } else {
                              prefs.setString('role', 'Admin');
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const HomeRoot();
                              }));
                            }
                            ;
                          }).catchError((err) {
                            setState(() {
                              isLoading = false;
                            });
                            Fluttertoast.showToast(msg: '$err');
                            print("user not found");
                          });
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
                          : const Text("Login")),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                    text: "Create an account ?  ",
                    children: [
                      TextSpan(
                        text: "Register",
                        style: TextStyle(color: blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return const RegisterScreen();
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
