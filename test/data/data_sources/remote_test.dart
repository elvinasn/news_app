import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/data/data_sources/remote/news_api.dart';

import 'remote_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late NewsApi newsApi;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    newsApi = NewsApi(mockDio);
  });

  group('newsApi getTopHeadlines', () {
    test('should return a list of articles when the call is successful',
        () async {
      final response = {
        'articles': [
          {
            'publishedAt': '2021-01-01T00:00:00.000',
            'title': 'title',
            'description': 'description',
            'url': 'https://bbc.com/random_id',
            'urlToImage': 'urlToImage',
            'author': 'author',
            'content': 'content',
          },
        ],
      };

      when(
        mockDio.get<Map<String, dynamic>>(
          any,
          queryParameters: anyNamed(
            'queryParameters',
          ),
        ),
      ).thenAnswer((_) async {
        return Response(
          data: response,
          statusCode: 200,
          requestOptions: RequestOptions(),
        );
      });

      final result = await newsApi.getTopHeadlines();

      expect(result.length, 1);
    });

    test('should throw a ServerFailure when the dio throws exception',
        () async {
      when(
        mockDio.get<Map<String, dynamic>>(
          any,
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenThrow(Exception());

      expect(
        () async {
          await newsApi.getTopHeadlines();
        },
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  test('should throw a ServerFailure when the status code is not 200',
      () async {
    when(
      mockDio.get<Map<String, dynamic>>(
        any,
        queryParameters: anyNamed('queryParameters'),
      ),
    ).thenAnswer((_) async {
      return Response(
        statusCode: 404,
        requestOptions: RequestOptions(),
      );
    });

    expect(
      () async {
        await newsApi.getTopHeadlines();
      },
      throwsA(isA<ServerFailure>()),
    );
  });
}
