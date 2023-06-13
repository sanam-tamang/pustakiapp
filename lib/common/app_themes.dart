import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pustakiapp/common/app_colors.dart';
import 'package:pustakiapp/common/app_text_styles.dart';

class AppThemes {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Color.fromARGB(255, 4, 7, 208),
        ),
        foregroundColor: MaterialStatePropertyAll(AppColors.whiteTextColor),
      )),
      colorScheme: ColorScheme.fromSeed(
          primary: AppColors.baseColor,
          seedColor: AppColors.baseColor,
          primaryContainer:const Color.fromARGB(255, 1, 4, 174),
          onPrimaryContainer: Colors.white),
      textTheme: GoogleFonts.robotoSerifTextTheme(
        TextTheme(
            titleLarge: AppTextStyle.blackTextStyle.copyWith(
              fontSize: 20,
            ),
            titleMedium: AppTextStyle.blackTextStyle.copyWith(
              fontSize: 18,
            ),
            titleSmall: AppTextStyle.blackTextStyle.copyWith(
              fontSize: 16,
            ),
            bodyLarge: AppTextStyle.blackTextStyle.copyWith(fontSize: 16),
            bodyMedium: AppTextStyle.blackTextStyle.copyWith(fontSize: 15),
            bodySmall: AppTextStyle.blackTextStyle.copyWith(fontSize: 14),
            labelLarge: AppTextStyle.greyTextStyle.copyWith(fontSize: 16),
            labelMedium: AppTextStyle.greyTextStyle.copyWith(fontSize: 15),
            labelSmall: AppTextStyle.greyTextStyle.copyWith(fontSize: 14),
            headlineSmall: AppTextStyle.blackTextStyle),
      ),
    );
  }
}
