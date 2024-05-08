import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/presentation/common/router/router.dart';
import 'package:news_app/presentation/common/utils/theme.dart';

final sl = GetIt.instance;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    sl.registerSingleton<AppRouter>(AppRouter());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior:
          const MaterialScrollBehavior().copyWith(scrollbars: false),
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            if (child != null) ...[
              OverlayEntry(
                builder: (context) {
                  return child;
                },
              ),
            ],
          ],
        );
      },
      title: 'News App',
      routerConfig: GetIt.I<AppRouter>().router,
      theme: AppTheme.themeData(),
    );
  }
}
