import 'package:flutter/material.dart';
import 'package:quiz_app/data/models/questions_model.dart';
import 'package:quiz_app/presentation/score/bloc/score_bloc.dart';
import 'package:quiz_app/presentation/welcome/cubit/welcome_cubit.dart';
import 'package:quiz_app/presentation/widgets/scrum_floating_button.dart';
import 'package:quiz_app/presentation/widgets/scrum_background_img.dart';
import 'package:quiz_app/presentation/widgets/scrum_loading.dart';
import 'package:quiz_app/utils/colors/scrum_colors.dart';
import 'package:quiz_app/presentation/widgets/question_card.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreView extends StatelessWidget {
  const ScoreView();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        return true;
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            const ScrumBackGroundImg(),
            BlocConsumer<ScoreBloc, ScoreState>(
              listener: (context, state) {
                if (state is ScoreLoaded) {
                  showDialog(
                    context: context,
                    builder: (context) => Center(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 160,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          color: ScrumColors.kWhite,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  '${state.score}%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      .copyWith(
                                        color: ScrumColors.kTextFieldBlue,
                                      ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 5),
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      color: ScrumColors.kTextFieldBlue),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  state.textDialog,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                        color: ScrumColors.kTextFieldBlue,
                                        fontSize: 26,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ScoreLoaded) {
                  return SafeArea(
                    child: Column(
                      children: [
                        _Header(
                          score: state.score,
                        ),
                        _ListViewScore(
                          questionsToAnswer: state.questions,
                        ),
                      ],
                    ),
                  );
                }
                return const ScrumLoading();
              },
            ),
            ScrumFloatingButton(
              width: MediaQuery.of(context).size.width * 0.5,
              text: 'Refazer Teste',
              onTap: () => context.read<WelcomeCubit>().getQuestions(),
            )
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String score;
  const _Header({
    this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: 'Total: ',
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: ScrumColors.kSecondary,
                    fontSize: 28,
                  ),
              children: [
                TextSpan(
                  text: '$score%',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: ScrumColors.kSecondary,
                        fontSize: 26,
                      ),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false),
            icon: const Icon(
              Icons.home_rounded,
              size: 26,
              color: ScrumColors.kSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ListViewScore extends StatelessWidget {
  final List<QuestionModel> questionsToAnswer;
  const _ListViewScore({
    @required this.questionsToAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: questionsToAnswer.length,
        padding: const EdgeInsets.only(bottom: 70),
        itemBuilder: (context, index) {
          return QuestionCard(
            question: questionsToAnswer[index],
            screen: 'score',
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: kDefaultPadding,
        ),
      ),
    );
  }
}
