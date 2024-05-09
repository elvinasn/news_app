import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/data/data_sources/remote/news_api.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl(
    this._newsApi,
  );
  final NewsApi _newsApi;

  @override
  Future<Either<Failure, List<Article>>> getTopHeadlines() async {
    try {
      final articles = await _newsApi.getTopHeadlines();
      return Right(articles);
    } catch (e) {
      return Left(e is Failure ? e : const ServerFailure());
    }
  }
}
