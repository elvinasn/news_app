import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/domain/repositories/news_repository.dart';
import 'package:news_app/domain/use-cases/get_top_headlines.dart';

import 'get_top_headlines_test.mocks.dart';

@GenerateMocks(
  [
    NewsRepository,
  ],
)
void main() {
  late GetTopHeadlines getTopHeadlines;
  late MockNewsRepository mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    getTopHeadlines = GetTopHeadlines(mockNewsRepository);
  });

  final testArticles = [
    Article(
      publishedAt: DateTime(2021),
      title: 'title',
      description: 'description',
      url: 'url',
      urlToImage: 'urlToImage',
      author: 'author',
      content: 'content',
    ),
  ];

  test('should get top headlines from the repository', () async {
    when(mockNewsRepository.getTopHeadlines())
        .thenAnswer((_) async => Right(testArticles));
    final result = await getTopHeadlines.execute();
    expect(
      result,
      // ignore: inference_failure_on_instance_creation
      Right(
        testArticles,
      ),
    );
  });

  test('should return failure when getting top headlines is unsuccessful',
      () async {
    when(mockNewsRepository.getTopHeadlines()).thenAnswer(
      (_) async => const Left<Failure, List<Article>>(ServerFailure()),
    );
    final result = await getTopHeadlines.execute();
    expect(
      result,
      const Left<Failure, List<Article>>(
        ServerFailure(),
      ),
    );
  });
}
