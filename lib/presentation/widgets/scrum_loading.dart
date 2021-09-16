import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors/scrum_colors.dart';

class ScrumLoading extends StatelessWidget {
  const ScrumLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: ScrumColors.kBlueLoading,
        color: ScrumColors.kGreenLoading,
      ),
    );
  }
}
