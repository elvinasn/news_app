import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/data/data_sources/remote/news_api.dart';
import 'package:news_app/data/repositories/news_repository_impl.dart';
import 'package:news_app/domain/repositories/news_repository.dart';
import 'package:news_app/domain/use-cases/get_top_headlines.dart';
import 'package:news_app/presentation/common/router/router.dart';
import 'package:news_app/presentation/common/store/news_store.dart';

final sl = GetIt.instance;

void init() {
  sl
    ..registerSingleton<Dio>(Dio())
    ..registerSingleton<NewsApi>(
      NewsApi(
        sl<Dio>(),
      ),
    )
    ..registerSingleton<NewsRepository>(
      NewsRepositoryImpl(
        sl<NewsApi>(),
      ),
    )
    ..registerSingleton<GetTopHeadlines>(
      GetTopHeadlines(
        sl<NewsRepository>(),
      ),
    )
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton<NewsStore>(
      NewsStore(
        sl<GetTopHeadlines>(),
      ),
    );
}
