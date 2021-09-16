import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/presentation/quiz/widgets/progress_bloc/progress_bloc.dart';
import 'package:quiz_app/presentation/welcome/cubit/welcome_cubit.dart';
import 'package:quiz_app/presentation/welcome/widgets/scrum_button_go.dart';
import 'package:quiz_app/presentation/welcome/widgets/scrum_textfield.dart';
import 'package:quiz_app/presentation/widgets/scrum_background_img.dart';
import 'package:quiz_app/presentation/widgets/scrum_loading.dart';
import 'package:quiz_app/utils/constants.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _BodyView(),
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
        BlocConsumer<WelcomeCubit, WelcomeState>(
          listener: (context, state) {
            if (state is WelcomeLoadSuccess) {
              context.read<ProgressBloc>().add(const ProgressReset(1));
              Navigator.pushNamed(context, '/quiz');
            }

            if (state is WelcomeLoadFailure) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Erro'),
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is WelcomeLoadInProgress) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ScrumLoading(),
                  const SizedBox(height: 5),
                  Text(
                    'Aguarde...',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              );
            }
            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(flex: 2),
                    Text(
                      'Bem Vindo',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Spacer(),
                    const ScrumTextField(),
                    const Spacer(),
                    ScrumButtonGo(
                      onTap: () => context.read<WelcomeCubit>().getQuestions(),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
