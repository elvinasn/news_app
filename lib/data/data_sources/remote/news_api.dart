// ignore_for_file: only_throw_errors

import 'package:dio/dio.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/data/models/article.dart';

class NewsApi {
  NewsApi(this._dio);
  final Dio _dio;

  static const topHeadingsPath = 'top-headlines';
  static const apiUrl = AppConstants.apiUrl;
  static const apiKey = AppConstants.apiKey;

  Future<List<Article>> getTopHeadlines() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$apiUrl$topHeadingsPath',
        queryParameters: {
          'country': 'us',
          'apiKey': apiKey,
        },
      );
      if (response.data == null || response.statusCode != 200) {
        throw const ServerFailure();
      }
      final articlesJson = response.data!['articles'] as List<dynamic>;

      return articlesJson
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw const ServerFailure();
    }
  }
}
