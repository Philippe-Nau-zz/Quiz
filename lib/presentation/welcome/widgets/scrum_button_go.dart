import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors/scrum_colors.dart';
import 'package:quiz_app/utils/constants.dart';

class ScrumButtonGo extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const ScrumButtonGo({
    @required this.onTap,
    this.text = 'Vamos Iniciar',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(kDefaultPadding * 0.75),
        decoration: const BoxDecoration(
          gradient: ScrumColors.kPrimaryGradient,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.button.copyWith(
                color: ScrumColors.kBlack,
              ),
        ),
      ),
    );
  }
}
