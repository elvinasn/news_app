import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/presentation/common/utils/colors.dart';
import 'package:news_app/presentation/common/utils/text_styles.dart';
import 'package:news_app/presentation/common/utils/theme_extension.dart';

class AppTheme {
  static ThemeData themeData() {
    final textStyles = AppTextStyles();
    final colors = AppColors();
    return ThemeData(
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.white,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textStyles.button1,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.white,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          shape: const StadiumBorder(),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
      ),
      scaffoldBackgroundColor: colors.bg,
      textTheme: TextTheme(
        displayLarge: textStyles.h1,
        displayMedium: textStyles.h2,
        displaySmall: textStyles.h3,
        headlineMedium: textStyles.h4,
        headlineSmall: textStyles.h5,
        titleLarge: textStyles.h6,
        labelLarge: textStyles.button1,
        labelMedium: textStyles.button2,
        labelSmall: textStyles.button3,
        bodyLarge: textStyles.body1,
        bodyMedium: textStyles.body2,
        bodySmall: textStyles.body3,
      ),
      extensions: [
        AppThemeExtension(
          colors: colors,
          styles: textStyles,
        ),
      ],
    );
  }
}
