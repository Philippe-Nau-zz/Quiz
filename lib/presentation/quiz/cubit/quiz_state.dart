part of 'quiz_cubit.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizLoaded extends QuizState {
  final List<QuestionModel> questionsList;
  final int questionNumber;
  final String textButton;
  const QuizLoaded({
    this.questionsList,
    this.questionNumber,
    this.textButton = 'Próxima Pergunta',
  });
  @override
  List<Object> get props => [questionsList, questionNumber, textButton];
}

class QuizFinished extends QuizState {
  const QuizFinished();
  @override
  List<Object> get props => [];
}
