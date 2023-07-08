import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/QuestionController.dart';
import 'EachQuestion.dart';

class QuestionScreen extends StatefulWidget {
  final List data;
  const QuestionScreen({super.key, required this.data});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var controller = PageController();
  int index = 1;
  int totalCount = 100;
  QuestionController questionController = Get.put(QuestionController());

  handleUpdateTotalCount(int length) {
    totalCount = length;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text("Question $index of ${widget.data.length}"),
          Expanded(
            child: PageView.builder(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    index = value + 1;
                    print(index);
                  });
                },
                itemCount: widget.data.length,
                itemBuilder: (context, index) {
                  var question = widget.data[index].data();
                  return EachQuestion(
                      index: index, question: question['question']);
                }),
          ),
        ],
      ),
    );
  }
}
