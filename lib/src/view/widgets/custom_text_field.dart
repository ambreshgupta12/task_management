import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final int maxLines;
  final int minLines;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  const CustomTextField({
    Key? key,
    @required this.controller,
    this.prefixIcon,
    @required this.hintText,
    @required this.hintStyle,
    @required this.style,
    this.obscureText = false,
    this.validator,
    this.maxLines = 1,
    this.minLines = 1,
    this.keyboardType = TextInputType.text, // Default value for keyboardType is set to text
    this.textInputAction = TextInputAction.go, // Default value for textInputAction is set to go
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      minLines: minLines,
      obscureText: obscureText!,
      style: style,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(),
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: hintStyle,
      ),
    );
  }
}
