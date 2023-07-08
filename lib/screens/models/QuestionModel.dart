import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  String? question;
  Timestamp? createdAt;

  QuestionModel({
    this.question,
    this.createdAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
        question: json['question'], createdAt: json['createdAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = question;
    data['createdAt'] = createdAt;
    return data;
  }
}
