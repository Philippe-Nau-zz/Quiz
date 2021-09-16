import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/data/models/questions_model.dart';
import 'package:quiz_app/utils/colors/scrum_colors.dart';

import '../../utils/constants.dart';
import 'option.dart';
import 'options_cubit/options_cubit.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    this.screen = 'quiz',
    @required this.question,
  });

  final QuestionModel question;
  final String screen;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.question,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: ScrumColors.kBlack),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          BlocBuilder<OptionsCubit, OptionsState>(
            builder: (context, state) {
              if (state is OptionsLoaded) {
                return Column(
                  children: [
                    ...List.generate(
                      question.options.length,
                      (index) {
                        return Option(
                          screen: screen,
                          index: index,
                          text: question.options[index],
                          isMarked: question.answered[index],
                          answer: question.answer,
                          press: () {
                            if (screen == 'quiz') {
                              context.read<OptionsCubit>().checkOption(
                                    question,
                                    index,
                                  );
                            }
                          },
                        );
                      },
                    ),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
          if (screen == 'score')
            ExpansionTile(
              title: Text(
                'Explicação',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: ScrumColors.kBlack),
              ),
              collapsedIconColor: ScrumColors.kBlack,
              iconColor: ScrumColors.kBlack,
              children: [
                ListTile(
                  title: Text(
                    question.answerExplanation,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: ScrumColors.kBlack,
                        ),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
