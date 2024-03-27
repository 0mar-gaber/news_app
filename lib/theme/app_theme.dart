import 'package:flutter/material.dart';
import 'package:news_app/theme/colors.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,

      ),
      centerTitle: true,
      backgroundColor: AppColors.primary,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,

      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        )
      )
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.white,
        primary: AppColors.primary

    )
  );
}