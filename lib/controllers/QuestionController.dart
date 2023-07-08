import 'dart:math';

import 'package:get/get.dart';
import 'package:onah_project/screens/Result.dart';

class QuestionController extends GetxController {
  var answers = [].obs;
  var questions = [].obs;
  var totalScore = 0.obs;
  var percentage = 0.0.obs;

  handleUpdateAnswer(int index, int value) {
    answers[index] = value;
    print(answers);
  }

  handleSubmit() {
    totalScore.value = 0;
    for (var answer in answers) {
      if (answer > 5) {
      } else {
        totalScore + answer;
      }
    }
    Get.to(Result());
    print("totalScore $totalScore");
    percentage.value = (totalScore.toInt() / ((answers.length) * 5));
    percentage.value *= 100;
    percentage.value = (percentage.value * pow(10, 1)).ceil() / pow(10, 1);
    print(percentage);
    print(answers);
  }
}
