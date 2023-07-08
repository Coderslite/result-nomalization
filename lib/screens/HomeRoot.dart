import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onah_project/screens/HomeScreen.dart';
import 'package:onah_project/screens/Normalization.dart';
import 'package:onah_project/screens/QuestionPage.dart';
import 'package:onah_project/screens/authentication/Login.dart';
import 'package:onah_project/screens/models/QuestionModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class HomeRoot extends StatefulWidget {
  const HomeRoot({super.key});

  @override
  State<HomeRoot> createState() => _HomeRootState();
}

class _HomeRootState extends State<HomeRoot> {
  TextEditingController questionController = TextEditingController();
  int index = 0;
  List pages = [
    const HomeScreen(),
    const NomalizationScreen(),
  ];

  handleChangePage(int idx) {
    setState(() {
      index = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: blue,
        actions: [
          TextButton(
            onPressed: () async{
              var prefs = await SharedPreferences.getInstance();
              prefs.remove('role');
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const LoginScreen();
                }));
              });
            },
            child: Text(
              "Logout",
              style: TextStyle(color: white),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: questionController,
                        decoration: const InputDecoration(
                          hintText: "Enter Question",
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: red),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.cancel),
                        label: const Text("Cancel")),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("Questions")
                              .add({
                            "question": questionController.text,
                            "createdAt": Timestamp.now(),
                          });
                          setState(() {
                            questionController.clear();
                          });
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Add"))
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                handleChangePage(0);
              },
              icon: Icon(Icons.home, color: index == 0 ? blue : Colors.grey),
            ),
            IconButton(
              onPressed: () {
                handleChangePage(1);
              },
              icon: Icon(Icons.question_answer_outlined,
                  color: index == 1 ? blue : Colors.grey),
            ),
          ],
        ),
      ),
      body: _getBody(),
    );
  }

  _getBody() {
    return pages[index];
  }
}
