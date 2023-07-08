import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/QuestionController.dart';

class EachQuestion extends StatefulWidget {
  final int index;
  final String question;
  const EachQuestion({super.key, required this.index, required this.question});

  @override
  State<EachQuestion> createState() => _EachQuestionState();
}

class _EachQuestionState extends State<EachQuestion> {
  QuestionController questionController = Get.put(QuestionController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                (widget.index + 1).toString() + ". ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.question,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          RadioListTile(
            value: 0,
            groupValue: questionController.answers[widget.index],
            onChanged: (va) {
              setState(() {
                questionController.handleUpdateAnswer(widget.index, 0);
              });
            },
            title: const Text("Not Applicable"),
            selected: false,
          ),
          RadioListTile(
            value: 1,
            groupValue: questionController.answers[widget.index],
            onChanged: (va) {
              setState(() {
                questionController.handleUpdateAnswer(widget.index, 1);
              });
            },
            title: const Text("Rarely"),
            selected: false,
          ),
          RadioListTile(
            value: 2,
            groupValue: questionController.answers[widget.index],
            onChanged: (va) {
              setState(() {
                questionController.handleUpdateAnswer(widget.index, 2);
              });
            },
            title: const Text("Occassionally"),
            selected: false,
          ),
          RadioListTile(
            value: 3,
            groupValue: questionController.answers[widget.index],
            onChanged: (va) {
              setState(() {
                questionController.handleUpdateAnswer(widget.index, 3);
              });
            },
            title: const Text("Frequently"),
            selected: false,
          ),
          RadioListTile(
            value: 4,
            groupValue: questionController.answers[widget.index],
            onChanged: (va) {
              setState(() {
                questionController.handleUpdateAnswer(widget.index, 4);
              });
            },
            title: const Text("Often"),
            selected: false,
          ),
          RadioListTile(
            value: 5,
            groupValue: questionController.answers[widget.index],
            onChanged: (va) {
              setState(() {
                questionController.handleUpdateAnswer(widget.index, 5);
              });
            },
            title: const Text("Always"),
            selected: false,
          ),
        ],
      ),
    );
  }
}
