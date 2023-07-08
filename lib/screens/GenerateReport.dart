import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class GenerateReport extends StatefulWidget {
  final String courseTitle;
  final String courseCode;

  const GenerateReport(
      {super.key, required this.courseTitle, required this.courseCode});

  @override
  State<GenerateReport> createState() => _GenerateReportState();
}

class _GenerateReportState extends State<GenerateReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Report",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Scores')
                  .where('courseTitle', isEqualTo: widget.courseTitle)
                  .orderBy('createdAt')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                // Process the data from the snapshot
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                return documents.isEmpty
                    ? const Center(
                        child: Text("No Scores Available for this course"),
                      )
                    : Table(
                        border:
                            TableBorder.all(width: 1, color: Colors.black45),
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
                                    "Matric No",
                                    style: TextStyle(color: white),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Raw Score",
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
                                    child: Text((counter + 1).toString()),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        documents[counter]['regNo'].toString()),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(documents[counter]['rawScore']
                                        .toString()),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(documents[counter]['nScore']
                                        .toString()),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      );
              },
            ),
          ],
        ),
      )),
    );
  }
}
