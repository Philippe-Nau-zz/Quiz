import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/presentation/quiz/view/quiz_page.dart';
import 'package:quiz_app/presentation/quiz/widgets/progress_bloc/progress_bloc.dart';
import 'package:quiz_app/presentation/score/views/score_page.dart';
import 'package:quiz_app/presentation/welcome/cubit/welcome_cubit.dart';
import 'package:quiz_app/presentation/welcome/views/welcome_page.dart';
import 'package:quiz_app/utils/ticker.dart';

import 'presentation/widgets/options_cubit/options_cubit.dart';

void main() {
  runApp(ScrumApp());
}

class ScrumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProgressBloc(ticker: const Ticker()),
        ),
        BlocProvider(
          create: (context) => OptionsCubit(),
        ),
        BlocProvider(
          create: (context) => WelcomeCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Simulado PSMI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        routes: {
          '/': (context) => const WelcomePage(),
          '/quiz': (context) => const QuizPage(),
          '/score': (context) => const ScorePage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
