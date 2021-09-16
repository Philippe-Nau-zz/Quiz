import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors/scrum_colors.dart';

class ScrumTextField extends StatelessWidget {
  const ScrumTextField();

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: ScrumColors.kTextFieldBlue,
          hintText: 'Seu Nome',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
