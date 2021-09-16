import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors/scrum_colors.dart';
import '../../utils/constants.dart';

class Option extends StatelessWidget {
  const Option({
    this.text,
    this.index,
    this.press,
    @required this.screen,
    this.isMarked = false,
    this.answer,
  });

  final String text;
  final int index;
  final String screen;
  final VoidCallback press;
  final bool isMarked;
  final List<int> answer;

  @override
  Widget build(BuildContext context) {
    Color _generateColor() {
      if (screen == 'quiz') {
        if (isMarked) {
          return ScrumColors.kOptionMarked;
        } else {
          return ScrumColors.kGray;
        }
      } else {
        if (answer.contains(index) && isMarked) {
          return ScrumColors.kGreen;
        } else if (!answer.contains(index) && isMarked) {
          return ScrumColors.kRed;
        } else if (answer.contains(index) && !isMarked) {
          return ScrumColors.kBlueLoading;
        } else {
          return ScrumColors.kGray;
        }
      }
    }

    IconData _generateIcon() {
      if (screen == 'quiz') {
        return Icons.done_rounded;
      } else {
        if (_generateColor() == ScrumColors.kGreen) {
          return Icons.done_all_rounded;
        } else if (_generateColor() == ScrumColors.kRed) {
          return Icons.close_rounded;
        } else if (_generateColor() == ScrumColors.kBlueLoading) {
          return Icons.star_rounded;
        } else {
          return null;
        }
      }
    }

    return InkWell(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(top: kDefaultPadding),
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          border: Border.all(color: _generateColor()),
          borderRadius: BorderRadius.circular(15),
          color: isMarked ? _generateColor().withOpacity(0.1) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => SizedBox(
                  width: constraints.maxWidth,
                  child: Text(
                    '${index + 1}. $text',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: _generateColor(),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: _generateColor() == ScrumColors.kGray
                    ? Colors.transparent
                    : _generateColor(),
                borderRadius:
                    answer.length > 1 ? BorderRadius.circular(5) : null,
                shape: answer.length > 1 ? BoxShape.rectangle : BoxShape.circle,
                border: Border.all(color: _generateColor()),
              ),
              child: Icon(
                _generateIcon(),
                size: 16,
                color: ScrumColors.kWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
