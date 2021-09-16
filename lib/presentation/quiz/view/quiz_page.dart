import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/presentation/quiz/cubit/quiz_cubit.dart';
import 'package:quiz_app/presentation/quiz/view/quiz_view.dart';

class QuizPage extends StatelessWidget {
  const QuizPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit()..getRandomQuestions(),
      child: const QuizView(),
    );
  }
}
