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
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
    ),
    chipTheme: ChipThemeData(
      side: BorderSide.none,
      color: WidgetStatePropertyAll(AppPallete.backgroundColor)
    ),
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      border: _border(),
      contentPadding: EdgeInsets.all(25),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.errorColor),
    )
  ); 
}