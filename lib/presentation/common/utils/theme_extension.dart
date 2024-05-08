import 'package:flutter/material.dart';
import 'package:news_app/presentation/common/utils/colors.dart';
import 'package:news_app/presentation/common/utils/text_styles.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  AppThemeExtension({
    required this.colors,
    required this.styles,
  });

  final AppColors colors;
  final AppTextStyles styles;

  @override
  AppThemeExtension copyWith({
    AppColors? colors,
    AppTextStyles? styles,
  }) {
    return AppThemeExtension(
      colors: colors ?? this.colors,
      styles: styles ?? this.styles,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    return this;
  }
}
