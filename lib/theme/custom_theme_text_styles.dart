import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/theme/exports_theme.dart';

class CustomThemeTextStyles {
  final _appColors = AppTheme.colors;

  TextStyle menu = TextStyle(
    color: Colors.white,
    fontFamily: AppTheme.font,
  );

  late TextStyle hintTextNotSelected =
      TextStyle(color: _appColors.borderGray, fontFamily: AppTheme.font);

  late TextStyle hintTextSelected =
      TextStyle(color: Colors.grey, fontFamily: AppTheme.font);
}
