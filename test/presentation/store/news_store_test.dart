import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/domain/use-cases/get_top_headlines.dart';
import 'package:news_app/presentation/common/store/news_store.dart';

import 'news_store_test.mocks.dart';

@GenerateMocks(
  [
    GetTopHeadlines,
  ],
)
void main() {
  late MockGetTopHeadlines mockGetTopHeadlines;

  late NewsStore newsStore;

  setUp(() {
    mockGetTopHeadlines = MockGetTopHeadlines();
    newsStore = NewsStore(mockGetTopHeadlines);
  });

  final testArticles = [
    Article(
      publishedAt: DateTime(2021),
      title: 'title',
      description: 'description',
      url: 'url/12321',
      urlToImage: 'urlToImage',
    ),
    Article(
      publishedAt: DateTime(2021),
      title: '[Removed]',
      description: 'description',
      url: 'url/12321',
      urlToImage: 'urlToImage',
    ),
  ];

  group('init', () {
    test('should set isLoading to true when called', () async {
      when(mockGetTopHeadlines.execute())
          .thenAnswer((_) async => const Right([]));
      unawaited(newsStore.init());
      expect(newsStore.isLoading, true);
    });

    test('should set isLoading to false when function ends', () async {
      when(mockGetTopHeadlines.execute())
          .thenAnswer((_) async => const Right([]));
      await newsStore.init();
      expect(newsStore.isLoading, false);
    });

    test('should set articles to the result of getTopHeadlines', () async {
      when(mockGetTopHeadlines.execute())
          .thenAnswer((_) async => Right(testArticles));
      await newsStore.init();
      expect(newsStore.articles, testArticles);
    });

    test('should set articles to empty list when getTopHeadlines fails',
        () async {
      when(mockGetTopHeadlines.execute())
          .thenAnswer((_) async => const Left(ServerFailure()));
      await newsStore.init();
      expect(newsStore.articles, <Article>[]);
    });
  });

  group('refresh', () {
    test('should set isLoading to true when called', () async {
      when(mockGetTopHeadlines.execute())
          .thenAnswer((_) async => const Right([]));
      unawaited(newsStore.refresh());
      expect(newsStore.isLoading, true);
    });

    test('should set isLoading to false when function ends', () async {
      when(mockGetTopHeadlines.execute())
          .thenAnswer((_) async => const Right([]));
      await newsStore.refresh();
      expect(newsStore.isLoading, false);
    });

    test('should set articles to the result of getTopHeadlines', () async {
      when(mockGetTopHeadlines.execute())
          .thenAnswer((_) async => Right(testArticles));
      await newsStore.refresh();
      expect(newsStore.articles, testArticles);
    });

    test('should set articles to empty list when getTopHeadlines fails',
        () async {
      when(mockGetTopHeadlines.execute())
          .thenAnswer((_) async => const Left(ServerFailure()));
      await newsStore.refresh();
      expect(newsStore.articles, <Article>[]);
    });
  });

  group('getArticle', () {
    test('should return the article with the given id', () async {
      when(mockGetTopHeadlines.execute())
          .thenAnswer((_) async => Right(testArticles));
      await newsStore.init();
      final article = newsStore.getArticle('12321');
      expect(article, testArticles[0]);
    });

    test('should return null if no article with the given id is found', () {
      when(mockGetTopHeadlines.execute())
          .thenAnswer((_) async => Right(testArticles));
      newsStore.init();
      final article = newsStore.getArticle('not found');
      expect(article, null);
    });
  });

  group('filteredArticles', () {
    test(
        'should return a list of articles without the ones with [Removed] title',
        () async {
      when(mockGetTopHeadlines.execute())
          .thenAnswer((_) async => Right(testArticles));
      await newsStore.init();
      final filteredArticles = newsStore.filteredArticles;
      expect(filteredArticles, [testArticles[0]]);
    });
  });
}
