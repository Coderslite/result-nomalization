import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:onah_project/constants/constants.dart';
import 'package:onah_project/screens/GenerateReport.dart';

class NomalizationScreen extends StatefulWidget {
  const NomalizationScreen({Key? key}) : super(key: key);

  @override
  State<NomalizationScreen> createState() => _NomalizationScreenState();
}

class _NomalizationScreenState extends State<NomalizationScreen> {
  double roundUpToOneDecimalPlace(double value) {
    return double.parse(value.toStringAsFixed(1));
  }

  String courseTitle = '';
  String courseCode = '';
  var nameController = TextEditingController();
  var regnoController = TextEditingController();
  var courseTitleController = TextEditingController();
  var courseCodeController = TextEditingController();
  var x = 0;
  var y = 0;
  var n = 0;
  var nScore = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("Add More Student Scores"),
                                  TextField(
                                    controller: courseTitleController,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Course Title"),
                                  ),
                                  TextField(
                                    controller: courseCodeController,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Course Code"),
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: red),
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("Courses")
                                          .add({
                                        "courseTitle":
                                            courseTitleController.text,
                                        "courseCode": courseCodeController.text,
                                        "createdAt": Timestamp.now(),
                                      }).then((value) {
                                        print("Course added");
                                        Fluttertoast.showToast(
                                            msg: 'Course Added');

                                        Get.back();
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: blue),
                                    child: const Text("Add Course")),
                              ],
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: blue),
                    label: const Text("Add Course"),
                    icon: const Icon(Icons.add),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("Add More Student Scores"),
                                  TextField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Name"),
                                  ),
                                  TextField(
                                    controller: regnoController,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Reg No"),
                                  ),
                                  TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        print(value);
                                        if (value.isEmpty) {
                                          x = 0;
                                        } else {
                                          x = int.parse(value.toString());
                                        }
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Score"),
                                  ),
                                  TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        if (value.isEmpty) {
                                          y = 0;
                                        } else {
                                          y = int.parse(value.toString());
                                        }
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Class Average"),
                                  ),
                                  TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        if (value.isEmpty) {
                                          n = 0;
                                        } else {
                                          n = int.parse(value.toString());
                                        }
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Class Size"),
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: red),
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (courseTitle.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "No Course is selected");
                                      } else {
                                        var p = x - y;
                                        var q = (p * p) / (n - 1);
                                        var s = sqrt(q);
                                        var z = p / s;
                                        var score = 50 + ((10 * p) / z);
                                        nScore =
                                            roundUpToOneDecimalPlace(score);
                                        print("p $p");
                                        print("q $q");
                                        print("s $s");
                                        print("z $z");
                                        print(nScore);
                                        print(score);
                                        var grade = nScore < 40
                                            ? 'F'
                                            : nScore > 40 && nScore < 45
                                                ? 'E'
                                                : nScore > 44 && nScore < 50
                                                    ? 'D'
                                                    : nScore > 49 && nScore < 60
                                                        ? 'C'
                                                        : nScore > 59 &&
                                                                nScore < 70
                                                            ? 'B'
                                                            : 'A';
                                        FirebaseFirestore.instance
                                            .collection("Scores")
                                            .add({
                                          "name": nameController.text,
                                          "regNo": regnoController.text,
                                          "rawScore": x,
                                          "nScore": nScore,
                                          "courseTitle": courseTitle,
                                          "grade": grade,
                                          "createdAt": Timestamp.now(),
                                        }).then((value) {
                                          print("scores added");
                                          Fluttertoast.showToast(
                                              msg: 'Score Added');
                                          Get.back();
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: blue),
                                    child: const Text("Add")),
                              ],
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: blue),
                    label: const Text("Add Record"),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('Courses')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final List<QueryDocumentSnapshot<Map<String, dynamic>>>
                      documents = snapshot.data!.docs;
                  final List<DropdownMenuItem<String>> dropdownItems = documents
                      .map((doc) => DropdownMenuItem<String>(
                            value: doc['courseTitle'],
                            child: Text(doc['courseTitle']),
                          ))
                      .toList();

                  return courseTitle.isEmpty
                      ? DropdownButtonFormField<String>(
                          items: dropdownItems,
                          onChanged: (val) {
                            setState(() {
                              courseTitle = val!;
                            });
                          },
                        )
                      : DropdownButtonFormField<String>(
                          items: dropdownItems,
                          value: courseTitle,
                          onChanged: (val) {
                            setState(() {
                              courseTitle = val!;
                            });
                          },
                        );
                },
              ),
              courseTitle == ''
                  ? const Center(
                      child: Text("Select Course to fetch"),
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Scores')
                          .where('courseTitle', isEqualTo: courseTitle)
                          .orderBy('createdAt')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        // Process the data from the snapshot
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        return documents.isEmpty
                            ? const Center(
                                child:
                                    Text("No Scores Available for this course"),
                              )
                            : Table(
                                border: TableBorder.all(
                                    width: 1, color: Colors.black45),
                                children: [
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color: blue,
                                    ),
                                    children: const [
                                      TableCell(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "S/N",
                                            style: TextStyle(color: white),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Name",
                                            style: TextStyle(color: white),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Reg no",
                                            style: TextStyle(color: white),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "NScore",
                                            style: TextStyle(color: white),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Grade",
                                            style: TextStyle(color: white),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Action",
                                            style: TextStyle(color: white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  for (int counter = 0;
                                      counter < documents.length;
                                      counter++)
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                                Text((counter + 1).toString()),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(documents[counter]
                                                    ['name']
                                                .toString()),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(documents[counter]
                                                    ['regNo']
                                                .toString()),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(documents[counter]
                                                    ['nScore']
                                                .toString()),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(documents[counter]
                                                    ['grade']
                                                .toString()),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              const Text(
                                                                "Actions",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              // InkWell(
                                                              //   onTap: () {},
                                                              //   child: ListTile(
                                                              //     title: Text(
                                                              //         "Edit"),
                                                              //   ),
                                                              // ),
                                                              InkWell(
                                                                onTap: () {
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "Scores")
                                                                      .doc(documents[
                                                                              counter]
                                                                          .id)
                                                                      .delete();
                                                                  Get.back();
                                                                },
                                                                child: ListTile(
                                                                  title: Text(
                                                                    "Delete",
                                                                    style: TextStyle(
                                                                        color:
                                                                            red),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Text("More")),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              );
                      },
                    ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: green),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return GenerateReport(
                        courseTitle: courseTitle,
                        courseCode: courseCode,
                      );
                    }));
                  },
                  child: const Text(
                    "Generate Report",
                    style: TextStyle(color: white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
