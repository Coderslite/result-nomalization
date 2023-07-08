import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onah_project/screens/EachQuestion.dart';
import 'package:onah_project/screens/authentication/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../controllers/QuestionController.dart';
import 'QuestionScreen.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  var controller = PageController();
  int index = 1;
  int totalCount = 100;
  QuestionController questionController = Get.put(QuestionController());

  handleUpdateTotalCount(int length) {
    totalCount = length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: blue,
          actions: [
            TextButton(
                onPressed: () async {
                  var prefs = await SharedPreferences.getInstance();
                  prefs.remove('role');
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const LoginScreen();
                    }));
                  });
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(color: white),
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: blue,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Are you sure you want to submit ?")
                          ],
                        ),
                        actionsAlignment: MainAxisAlignment.spaceBetween,
                        actions: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.cancel),
                            label: const Text("Cancle"),
                            style:
                                ElevatedButton.styleFrom(backgroundColor: red),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Get.back();
                              questionController.handleSubmit();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: green),
                            icon: const Icon(Icons.done),
                            label: const Text("Proceed"),
                          ),
                        ],
                      ));
            },
            child: const Icon(Icons.done)),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Internet Addiction Test",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25, color: blue),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Questions")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text("Something went wrong"));
                    }
                    if (snapshot.hasData) {
                      var data = snapshot.data!.docs;
                      handleUpdateTotalCount(data.length);
                      questionController.answers.value = [];
                      for (int x = 0; x < totalCount; x++) {
                        questionController.answers.add(10);
                      }
                      return QuestionScreen(
                        data: data,
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  })
            ],
          ),
        )));
  }
}
