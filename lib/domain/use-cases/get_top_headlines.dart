import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/domain/repositories/news_repository.dart';

class GetTopHeadlines {
  GetTopHeadlines(
    this._newsRepository,
  );

  final NewsRepository _newsRepository;

  Future<Either<Failure, List<Article>>> execute() async {
    return _newsRepository.getTopHeadlines();
  }
}
