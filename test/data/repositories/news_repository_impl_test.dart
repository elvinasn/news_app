import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/data/data_sources/remote/news_api.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/data/repositories/news_repository_impl.dart';

import 'news_repository_impl_test.mocks.dart';

@GenerateMocks([
  NewsApi,
])
void main() {
  late MockNewsApi mockNewsApi;

  late NewsRepositoryImpl newsRepositoryImpl;

  setUp(() {
    mockNewsApi = MockNewsApi();
    newsRepositoryImpl = NewsRepositoryImpl(mockNewsApi);
  });

  final testArticles = [
    Article(
      publishedAt: DateTime(2021),
      title: 'title',
      description: 'description',
      url: 'url',
      urlToImage: 'urlToImage',
    ),
  ];

  group('getTopHeadlines', () {
    test('should return a list of articles when the call is successful',
        () async {
      when(mockNewsApi.getTopHeadlines()).thenAnswer((_) async => testArticles);
      final result = await newsRepositoryImpl.getTopHeadlines();
      expect(result, Right<Failure, List<Article>>(testArticles));
    });

    test('should return a ServerFailure when the api throws exception',
        () async {
      when(mockNewsApi.getTopHeadlines()).thenThrow(const ServerFailure());
      final result = await newsRepositoryImpl.getTopHeadlines();
      expect(result, const Left<Failure, List<Article>>(ServerFailure()));
    });
  });
}
