import 'package:drift/drift.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/data/tables/articles.dart';
import 'package:news_app/data/tables/database.dart';

part 'news_dao.g.dart';

@DriftAccessor(
  tables: [Articles],
)
class NewsDao extends DatabaseAccessor<AppDatabase> with _$NewsDaoMixin {
  NewsDao(super.db);

  Future<List<Article>> getAllNews() async {
    final result = await select(articles).get();
    return result.map(Article.fromDb).toList();
  }

  Future<void> saveNews(
    List<Article> news,
  ) {
    return batch((batch) {
      batch.insertAll(
        articles,
        news.map((e) => e.toDb()).toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }
}
