


import 'package:flutter/material.dart';
import 'package:github_search/constants/colors/color_styles.dart';
import 'package:github_search/constants/texts/text_styles.dart';

class PrimaryBtn extends StatelessWidget {
  final Function() onTap;
  final String text;
  final double? height;
  final bool isRed;
  const PrimaryBtn({
    required this.onTap,
    required this.text,
    this.height,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isRed ?  ColorStyles.redAccent : ColorStyles.primary,
        ),
        alignment: Alignment.center,
        child: Text(text, style: TextStyles.white18w700,),
      ),
    );
  }
}