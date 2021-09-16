import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/data/models/questions_model.dart';
import 'package:quiz_app/utils/sort_questions.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(const QuizLoaded(questionsList: []));

  final PageController pageController = PageController();
  int _currentQuestion = 1;
  bool _nextPageInProgress = true;
  String _textButton = 'Próxima Pergunta';

  Future<void> nextQuestion() async {
    if (_currentQuestion <= questionsToAnswer.length && _nextPageInProgress) {
      _nextPageInProgress = false;
      await pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      _nextPageInProgress = true;
      _currentQuestion++;
      if (_currentQuestion == questionsToAnswer.length) {
        _textButton = 'Finalizar';
      }
      emit(
        QuizLoaded(
          questionsList: List.of(questionsToAnswer),
          questionNumber: _currentQuestion,
          textButton: _textButton,
        ),
      );
    }

    if (_currentQuestion > questionsToAnswer.length) {
      emit(
        const QuizFinished(),
      );
    }
  }

  Future<void> getRandomQuestions() async {
    emit(
      QuizLoaded(
        questionsList: List.of(questionsToAnswer),
        questionNumber: _currentQuestion,
      ),
    );
  }
}
