import 'package:flutter/material.dart';
import 'package:github_search/constants/colors/color_styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class Loader extends StatelessWidget {
  const Loader({super.key});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fallingDot(
        color: ColorStyles.grey888,
        size: 30,
      ),
    );
  }
}