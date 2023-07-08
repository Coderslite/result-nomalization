import 'package:flutter/material.dart';

class AdminEachQuestion extends StatefulWidget {
  const AdminEachQuestion({super.key});

  @override
  State<AdminEachQuestion> createState() => _AdminEachQuestionState();
}

class _AdminEachQuestionState extends State<AdminEachQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("How old are you"),
        ],
      ),
    );
  }
}
