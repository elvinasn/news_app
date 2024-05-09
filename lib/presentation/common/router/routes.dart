abstract class AppRoute {
  const AppRoute({
    required this.name,
    required this.path,
    required this.params,
    this.queryParams,
    this.extra,
  });

  final String name;
  final String path;
  final Map<String, String> params;
  final Map<String, String>? queryParams;
  final Object? extra;
}

class HomePageRoute extends AppRoute {
  HomePageRoute()
      : super(
          name: 'home',
          path: '/',
          params: {},
        );
}

class ArticleRoute extends AppRoute {
  ArticleRoute({
    required String id,
  }) : super(
          name: 'article',
          path: '/article/:id',
          params: {
            'id': id,
          },
        );
}

class WebViewRoute extends AppRoute {
  WebViewRoute({required String url})
      : super(
          path: '/webview',
          name: 'webview',
          params: {},
          extra: url,
        );
}
