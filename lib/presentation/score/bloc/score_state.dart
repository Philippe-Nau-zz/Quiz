part of 'score_bloc.dart';

abstract class ScoreState extends Equatable {
  const ScoreState();

  @override
  List<Object> get props => [];
}

class ScoreLoaded extends ScoreState {
  final String score;
  final String textDialog;
  final List<QuestionModel> questions;
  const ScoreLoaded({
    this.score,
    this.textDialog,
    this.questions,
  });
  @override
  List<Object> get props => [score, questions, textDialog];
}

class ScoreLoadInProgress extends ScoreState {
  const ScoreLoadInProgress();
  @override
  List<Object> get props => [];
}
