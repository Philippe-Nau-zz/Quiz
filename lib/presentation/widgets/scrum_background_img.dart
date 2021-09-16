import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_app/utils/assets/scrum_images.dart';

class ScrumBackGroundImg extends StatelessWidget {
  const ScrumBackGroundImg();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      ScrumImages.kBackgroundImage,
      fit: BoxFit.fill,
      width: double.maxFinite,
    );
  }
}
