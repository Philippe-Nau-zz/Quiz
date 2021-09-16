import 'package:flutter/material.dart';
import 'package:quiz_app/presentation/quiz/cubit/quiz_cubit.dart';
import 'package:quiz_app/presentation/quiz/widgets/progress_bar.dart';
import 'package:quiz_app/presentation/quiz/widgets/progress_bloc/progress_bloc.dart';
import 'package:quiz_app/presentation/quiz/widgets/scrum_question_indicator.dart';
import 'package:quiz_app/presentation/widgets/question_card.dart';
import 'package:quiz_app/presentation/widgets/scrum_background_img.dart';
import 'package:quiz_app/presentation/widgets/scrum_floating_button.dart';
import 'package:quiz_app/presentation/widgets/scrum_loading.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizView extends StatelessWidget {
  const QuizView();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: const _BodyView(),
      ),
    );
  }
}

class _BodyView extends StatelessWidget {
  const _BodyView();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ScrumBackGroundImg(),
        SafeArea(
          child: BlocConsumer<QuizCubit, QuizState>(
            listener: (context, state) {
              if (state is QuizFinished) {
                Navigator.of(context).pushReplacementNamed('/score');
              }
            },
            builder: (context, state) {
              if (state is QuizLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProgressBar(),
                    const SizedBox(height: kDefaultPadding),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: double.maxFinite,
                      child: ScrumQuestionIndicator(
                        questionNumber: '${state.questionNumber}',
                        quantionsTotal: '${state.questionsList.length}',
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                      height: 0,
                    ),
                    _QuestionPageView(
                      state: state,
                    ),
                  ],
                );
              }
              return const ScrumLoading();
            },
          ),
        )
      ],
    );
  }
}

class _QuestionPageView extends StatelessWidget {
  final QuizLoaded state;
  const _QuestionPageView({
    @required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<QuizCubit>();
    return Expanded(
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _bloc.pageController,
        itemCount: state.questionsList.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: kDefaultPadding,
                  bottom: 70,
                ),
                child: QuestionCard(
                  question: state.questionsList[index],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ScrumFloatingButton(
                  text: state.textButton,
                  width: MediaQuery.of(context).size.width * 0.5,
                  onTap: () => context.read<ProgressBloc>().add(
                        const ProgressJumped(),
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
