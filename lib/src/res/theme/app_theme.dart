import 'package:flutter/material.dart';
import 'package:task_manager/src/constants/color_constants.dart';
import 'package:task_manager/src/constants/string_constants.dart';

class AppTheme {
  AppTheme._();
  static final ThemeData lightTheme = ThemeData(
    primaryColor: KColors.deepPurple,
    colorScheme: ColorScheme.fromSeed(seedColor: KColors.deepPurple),
    scaffoldBackgroundColor: KColors.whiteColor,
    fontFamily: KString.openSansFont,
    brightness: Brightness.light,
  );
}
