import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/presentation/score/bloc/score_bloc.dart';
import 'package:quiz_app/presentation/score/views/score_view.dart';

class ScorePage extends StatelessWidget {
  const ScorePage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScoreBloc()..add(ScoreCalc()),
      child: const ScoreView(),
    );
  }
}
