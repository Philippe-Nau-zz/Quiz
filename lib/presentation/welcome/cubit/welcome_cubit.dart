import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/data/repository/questions_repository.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:quiz_app/utils/sort_questions.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(const WelcomeLoaded());

  final QuestionsRepository _questionsRepository = QuestionsRepository();

  Future<void> getQuestions() async {
    emit(const WelcomeLoadInProgress());
    if (allQuestions.length < kRandomListLenght) {
      final _response = await _questionsRepository.fetchQuestions();
      _response.fold(
        (left) async {
          emit(
            WelcomeLoadFailure(error: left),
          );
        },
        (right) async {
          allQuestions = right;
          await sortQuestions(List.of(allQuestions));
          emit(const WelcomeLoadSuccess());
        },
      );
    } else {
      await sortQuestions(List.of(allQuestions));
      emit(const WelcomeLoadSuccess());
    }
  }
}
