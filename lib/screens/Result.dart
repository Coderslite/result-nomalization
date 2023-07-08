import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:onah_project/constants/constants.dart';

import '../controllers/QuestionController.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  QuestionController questionController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: blue,
                radius: 80,
                child: Center(
                  child: Text(
                    "${questionController.percentage.string} %",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                questionController.percentage < 30
                    ? "Normal Level of internet Usuage"
                    : questionController.percentage >= 30 &&
                            questionController.percentage < 50
                        ? "Mild Level of internet Addiction"
                        : questionController.percentage >= 50 &&
                                questionController.percentage < 80
                            ? "Moderate Level of internet Addiction"
                            : "Severe Dependency Upon the internet",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              )
            ],
          ),
        ),
      )),
    );
  }
}
