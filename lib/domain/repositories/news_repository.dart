import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/data/models/article.dart';

// ignore: one_member_abstracts
abstract class NewsRepository {
  Future<Either<Failure, List<Article>>> getTopHeadlines();
}
