// Drift table definition for articles
import 'package:drift/drift.dart';

@DataClassName('ArticleEntity')
class Articles extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get url => text()();
  TextColumn get urlToImage => text().nullable()();
  TextColumn get author => text().nullable()();
  TextColumn get content => text().nullable()();
  DateTimeColumn get publishedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
