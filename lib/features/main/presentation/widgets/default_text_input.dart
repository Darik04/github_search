import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_search/constants/colors/color_styles.dart';
import 'package:github_search/constants/texts/text_styles.dart';



class DefaultTextFormField extends StatelessWidget {
  final String hint;
  final String? title;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final Function(String? val)? onChange;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? maxLength;
  final bool obscureText;
  final bool isBlack;
  const DefaultTextFormField({
    Key? key,
    this.focusNode,
    this.maxLength,
    this.onTap,
    this.onChange,
    this.maxLines,
    required this.hint,
    this.title,
    this.validator,
    this.isBlack = true,
    this.obscureText = false,
    this.controller,
    this.inputFormatters,
    this.keyboardType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return TextFormField(
      expands: true,
      focusNode: focusNode,
      onTap: onTap,
      onChanged: onChange,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      style: isBlack ? TextStyles.white18w400 : TextStyles.black18w400,
      maxLength: maxLength,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 30,),
        hintText: hint,
        filled: true,
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        fillColor: isBlack ? ColorStyles.black2 : ColorStyles.white,
        hintStyle: TextStyles.white18w400
      ),
    );
  }
}