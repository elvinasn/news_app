import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/data/tables/database.dart';

part 'article.g.dart';

@JsonSerializable()
class Article extends Equatable {
  const Article({
    required this.title,
    required this.url,
    required this.publishedAt,
    this.urlToImage,
    this.content,
    this.author,
    this.description,
  });

  factory Article.fromDb(ArticleEntity dbArticle) {
    return Article(
      title: dbArticle.title,
      description: dbArticle.description,
      url: dbArticle.url,
      urlToImage: dbArticle.urlToImage,
      author: dbArticle.author,
      content: dbArticle.content,
      publishedAt: dbArticle.publishedAt,
    );
  }

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  final String? author;
  final String title;
  final String? description;
  final String url;

  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;

  String get id {
    final lastPart = url.split('/').lastOrNull ?? '';
    return lastPart.isNotEmpty ? lastPart : title;
  }

  String get formattedDate =>
      DateFormat('dd MMM yyyy hh:mm').format(publishedAt);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  ArticlesCompanion toDb() => ArticlesCompanion.insert(
        id: id,
        title: title,
        url: url,
        publishedAt: publishedAt,
        urlToImage: Value(urlToImage),
        author: Value(author),
        content: Value(content),
        description: Value(description),
      );
  @override
  List<Object?> get props => [
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
}
