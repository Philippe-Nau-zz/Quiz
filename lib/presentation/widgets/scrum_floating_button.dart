import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors/scrum_colors.dart';

class ScrumFloatingButton extends StatelessWidget {
  final VoidCallback onTap;
  final double width;
  final String text;
  const ScrumFloatingButton({
    this.onTap,
    this.width,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.all(10),
          width: width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: ScrumColors.kPrimaryGradient,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: ScrumColors.kBlack.withOpacity(0.7),
              ),
            ],
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: ScrumColors.kBlack,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
