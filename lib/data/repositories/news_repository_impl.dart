import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/data/data_sources/local/news_dao.dart';
import 'package:news_app/data/data_sources/remote/news_api.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl(
    this._newsApi,
    this._newsDao,
  );
  final NewsApi _newsApi;
  final NewsDao _newsDao;

  @override
  Future<Either<Failure, List<Article>>> getTopHeadlines() async {
    try {
      final connectivityResult =
          await Connectivity().checkConnectivity().catchError(
                (e) => [
                  ConnectivityResult.mobile,
                ],
              );
      if (connectivityResult.contains(ConnectivityResult.none)) {
        final articles = await _newsDao.getAllNews();
        return Right(articles);
      }
      final articles = await _newsApi.getTopHeadlines();
      await _newsDao.saveNews(articles);
      return Right(articles);
    } catch (e) {
      return Left(e is Failure ? e : const ServerFailure());
    }
  }
}
