import 'dart:core';

class FaqModel {
  late String question;
  late String answer;


  FaqModel(
      this.question,
      this.answer,
     );

  factory FaqModel.fromJson(Map<String, dynamic> document) {
    return FaqModel(
        document["question"],
        document["answer"],
        );
  }
}
