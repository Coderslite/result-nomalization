import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onah_project/screens/HomeRoot.dart';
import 'package:onah_project/screens/QuestionPage.dart';
import 'package:onah_project/screens/authentication/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/constants.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(
    isLoggedIn: user == null ? false : true,
    user: user,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final User? user;
  const MyApp({super.key, required this.isLoggedIn, required this.user});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(
        user: user,
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final User? user;
  const SplashScreen({super.key, required this.user});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  handleNextScreen() {
    Timer(const Duration(seconds: 3), () async {
      if (widget.user != null) {
        var prefs = await SharedPreferences.getInstance();
        String role = prefs.getString('role').toString();
        if (role == 'User') {
          Get.to(
            const QuestionPage(),
          );
        } else {
          Get.to(
            const HomeRoot(),
          );
        }
      } else {
        Get.to(
          const LoginScreen(),
        );
      }
    });
  }

  @override
  void initState() {
    handleNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Internet Addiction Test",
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Center(
                  child: CircularProgressIndicator(
                color: white,
              )),
            ],
          ),
        ));
  }
}
