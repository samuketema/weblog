import 'package:flutter/material.dart ';
import 'package:weblog/core/theme/app_pallete.dart';

class AppTheme {
  static  _border ([ Color color = AppPallete.borderColor])=>
  OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 2,
          color: color
        )
  );
  static final darktheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(7),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
    )
  );
}