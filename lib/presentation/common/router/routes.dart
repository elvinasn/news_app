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
