import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/presentation/common/router/routes.dart';
import 'package:news_app/presentation/common/utils/colors.dart';
import 'package:news_app/presentation/common/utils/text_styles.dart';
import 'package:news_app/presentation/common/utils/theme_extension.dart';

extension ContextExtensions on BuildContext {
  void goRoute(AppRoute route) =>
      goNamed(route.name, pathParameters: route.params, extra: route.extra);

  void pushRoute(AppRoute route) => pushNamed(
        route.name,
        pathParameters: route.params,
        extra: route.extra,
      );

  AppColors get colors => Theme.of(this).extension<AppThemeExtension>()!.colors;

  AppTextStyles get styles =>
      Theme.of(this).extension<AppThemeExtension>()!.styles;
}

extension IntX on int {
  Widget get heightBox => SizedBox(height: toDouble());
  Widget get widthBox => SizedBox(width: toDouble());
}
