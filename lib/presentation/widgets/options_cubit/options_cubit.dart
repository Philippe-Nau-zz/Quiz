import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/data/models/questions_model.dart';

part 'options_state.dart';

class OptionsCubit extends Cubit<OptionsState> {
  OptionsCubit() : super(const OptionsLoaded());

  // ignore: unused_field
  bool _isMarked;

  Future<void> checkOption(QuestionModel questionModel, int indexAswer) async {
    emit(const OptionsLoadInProgress());
    final _stateOption = !questionModel.answered[indexAswer];
    if (questionModel.answer.length == 1) {
      for (var i = 0; i < questionModel.answered.length; i++) {
        questionModel.answered[i] = false;
      }
    }
    questionModel.answered[indexAswer] = _stateOption;
    emit(const OptionsLoaded());
  }
}
