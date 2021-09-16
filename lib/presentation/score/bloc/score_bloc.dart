import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:quiz_app/data/models/questions_model.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:quiz_app/utils/sort_questions.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc() : super(const ScoreLoadInProgress());

  final int _questionsLenght = questionsToAnswer.length;
  final List<int> _answeredIndex = [];
  int _correctQuestions = 0;
  double _userScore = 0;
  bool _isCorrect;
  String _textDialog = 'Aprovado';

  @override
  Stream<ScoreState> mapEventToState(
    ScoreEvent event,
  ) async* {
    if (event is ScoreCalc) {
      for (final questions in questionsToAnswer) {
        _answeredIndex.clear();
        for (var i = 0; i < questions.answered.length; i++) {
          if (questions.answered[i]) {
            _answeredIndex.add(i);
          }
        }
        _isCorrect = listEquals(_answeredIndex, questions.answer);
        if (_isCorrect) {
          _correctQuestions++;
        }
      }
    }

    _userScore = _calcFinalScore(_questionsLenght, _correctQuestions);

    if (_userScore >= kScoreMin) {
      _textDialog = 'Aprovado';
    } else {
      _textDialog = 'Reprovado';
    }

    yield ScoreLoaded(
      score: _userScore.toStringAsFixed(0),
      textDialog: _textDialog,
      questions: List.of(questionsToAnswer),
    );
  }
}

double _calcFinalScore(int questionsLenght, int correctQuestion) {
  final _result = (100 / questionsLenght) * correctQuestion;
  return _result;
}
