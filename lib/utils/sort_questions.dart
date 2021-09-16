import 'dart:math';

import 'package:quiz_app/data/models/questions_model.dart';
import 'package:quiz_app/utils/constants.dart';

Set<QuestionModel> randomQuestions = {};
List<QuestionModel> allQuestions = [];
List<QuestionModel> questionsToAnswer = [];
Random _random = Random();

Future<void> sortQuestions(List<QuestionModel> questionsList) async {
  randomQuestions.clear();
  if (allQuestions.length > kRandomListLenght) {
    while (
        randomQuestions.length < kRandomListLenght && allQuestions.isNotEmpty) {
      final _index = _random.nextInt(allQuestions.length);
      randomQuestions.add(
        allQuestions[_index],
      );
    }
  } else {
    while (randomQuestions.length != allQuestions.length) {
      final _index = _random.nextInt(allQuestions.length);
      randomQuestions.add(
        allQuestions[_index],
      );
    }
  }
  questionsToAnswer = randomQuestions.toList();
  deleteQuestion();
}

Future<void> deleteQuestion() async {
  for (final q in randomQuestions) {
    allQuestions.removeWhere((e) => e.id == q.id);
  }
}
