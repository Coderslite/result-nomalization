import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onah_project/screens/models/QuestionModel.dart';
import 'package:onah_project/widgets/admin_each_question.dart';

import '../constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                  "Questions",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text("Slide left/right to delete question"),
                Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Questions")
                            .orderBy('createdAt')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Something went wrong"),
                            );
                          } else if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var question =
                                      snapshot.data!.docs[index].data();
                                  return Dismissible(
                                    onDismissed: (direction) {
                                      FirebaseFirestore.instance
                                          .collection("Questions")
                                          .doc(snapshot.data!.docs[index].id)
                                          .delete();
                                      snapshot.data!.docs.removeWhere(
                                          (element) =>
                                              element.data()['question'] ==
                                              question['question']);
                                    },
                                    background: Container(
                                      decoration: BoxDecoration(color: red),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: white,
                                          )
                                        ],
                                      ),
                                    ),
                                    key: Key(index.toString()),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 10,
                                        child: Text((index + 1).toString()),
                                      ),
                                      title: Text(
                                        question['question'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: blue,
                              ),
                            );
                          }
                        }))
              ],
            ),
          ),
        ));
  }
}
