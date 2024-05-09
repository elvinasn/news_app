import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/data/models/article.dart';

void main() {
  const articleId = 'random_id';
  final testModel = Article(
    publishedAt: DateTime(2021),
    title: 'title',
    description: 'description',
    url: 'https://bbc.com/$articleId',
    urlToImage: 'urlToImage',
    author: 'author',
    content: 'content',
  );
  test('should return a valid model using fromJson', () async {
    final jsonMap = <String, dynamic>{
      'publishedAt': '2021-01-01T00:00:00.000',
      'title': 'title',
      'description': 'description',
      'url': 'https://bbc.com/$articleId',
      'urlToImage': 'urlToImage',
      'author': 'author',
      'content': 'content',
    };
    final result = Article.fromJson(jsonMap);
    expect(result, testModel);
  });

  test('should return a JSON map containing the proper data using toJson',
      () async {
    final result = testModel.toJson();
    final expectedJsonMap = <String, dynamic>{
      'publishedAt': '2021-01-01T00:00:00.000',
      'title': 'title',
      'description': 'description',
      'url': 'https://bbc.com/$articleId',
      'urlToImage': 'urlToImage',
      'author': 'author',
      'content': 'content',
    };
    expect(result, expectedJsonMap);
  });

  test('should return id from url when there is id in url', () async {
    expect(testModel.id, articleId);
  });

  test('should return id from title when there is no id in url', () async {
    final model = Article(
      publishedAt: DateTime(2021),
      title: 'title',
      description: 'description',
      url: 'https://bbc.com/',
      urlToImage: 'urlToImage',
    );
    expect(model.id, model.title);
  });
}
