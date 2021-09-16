import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors/scrum_colors.dart';
import 'package:quiz_app/utils/constants.dart';

class ScrumQuestionIndicator extends StatelessWidget {
  final String questionNumber;
  final String quantionsTotal;
  const ScrumQuestionIndicator({
    this.quantionsTotal,
    this.questionNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Text.rich(
        TextSpan(
          text: 'Questão $questionNumber',
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: ScrumColors.kSecondary),
          children: [
            TextSpan(
              text: '/$quantionsTotal',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: ScrumColors.kSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
