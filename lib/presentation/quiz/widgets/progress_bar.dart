import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_app/presentation/quiz/cubit/quiz_cubit.dart';
import 'package:quiz_app/presentation/quiz/widgets/progress_bloc/progress_bloc.dart';
import 'package:quiz_app/utils/assets/scrum_images.dart';
import 'package:quiz_app/utils/colors/scrum_colors.dart';

import '../../../utils/constants.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar();

  @override
  Widget build(BuildContext context) {
    return const ProgressBarView();
  }
}

class ProgressBarView extends StatelessWidget {
  const ProgressBarView();

  @override
  Widget build(BuildContext context) {
    final duration = context.select((ProgressBloc bloc) => bloc.state.duration);
    context.read<ProgressBloc>().add(ProgressStarted(duration: duration));
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(
          color: ScrumColors.kProgressBlue,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: BlocConsumer<ProgressBloc, ProgressState>(
        listener: (context, state) {
          if (state is ProgressRunComplete) {
            context.read<QuizCubit>().nextQuestion();
            context.read<ProgressBloc>().add(const ProgressReset(1));
          }
        },
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          return Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) => Container(
                  width: constraints.maxWidth * (duration / 60),
                  decoration: BoxDecoration(
                    gradient: ScrumColors.kPrimaryGradient,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$duration sec'),
                      SvgPicture.asset(ScrumImages.kClock),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
