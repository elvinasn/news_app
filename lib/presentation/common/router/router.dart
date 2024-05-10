import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:go_router/go_router.dart';
import 'package:news_app/presentation/common/router/routes.dart';
import 'package:news_app/presentation/common/store/analytics_store.dart';
import 'package:news_app/presentation/screens/article_screen.dart';
import 'package:news_app/presentation/screens/home_screen.dart';
import 'package:news_app/presentation/screens/webview_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter(
    this._analyticsStore,
    this._firebaseAnalytics,
  );
  final AnalyticsStore _analyticsStore;
  final FirebaseAnalytics _firebaseAnalytics;
  late final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    observers: [
      FirebaseAnalyticsObserver(
        analytics: _firebaseAnalytics,
      ),
    ],
    redirect: (context, state) {
      return null;
    },
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            name: 'article',
            path: 'article/:id',
            builder: (context, state) {
              _analyticsStore.logEvent('article_viewed', {
                'article_id': state.pathParameters['id'],
              });
              final id = state.pathParameters['id'];
              return ArticleScreen(articleId: id ?? '');
            },
          ),
          GoRoute(
            path: 'webview',
            name: 'webview',
            builder: (context, state) {
              _analyticsStore.logEvent('webview_opened', {
                'url': state.extra,
              });
              final extra = state.extra! as String;
              return WebViewScreen(url: extra);
            },
          ),
        ],
      ),
    ],
  );

  void goForced(String route) {
    router.go(
      route,
    );
  }

  void go(AppRoute route, {Map<String, String>? params, Object? extra}) {
    router.goNamed(
      route.name,
      pathParameters: params ?? route.params,
      queryParameters: route.queryParams ?? {},
      extra: extra ?? route.extra,
    );
  }

  Future<T?> push<T>(AppRoute route) async {
    return router.pushNamed<T>(
      route.name,
      pathParameters: route.params,
      queryParameters: route.queryParams ?? {},
      extra: route.extra,
    );
  }

  Future<T?> pushReplacement<T>(AppRoute route) async {
    return router.pushReplacementNamed<T>(
      route.name,
      pathParameters: route.params,
      queryParameters: route.queryParams ?? {},
      extra: route.extra,
    );
  }

  Future<T?> pushNamed<T>(
    String route, {
    Map<String, String>? params,
    Object? extra,
  }) async {
    return router.pushNamed<T>(
      route,
      pathParameters: params ?? {},
      extra: extra,
    );
  }

  String? get location =>
      context != null ? GoRouterState.of(context!).uri.toString() : null;

  BuildContext? get context =>
      router.routerDelegate.navigatorKey.currentContext;

  void pop<T extends Object?>([T? result]) {
    router.pop(result);
  }
}
