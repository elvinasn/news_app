import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

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
