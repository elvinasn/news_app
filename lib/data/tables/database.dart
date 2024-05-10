import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:news_app/data/tables/articles.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Articles,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase({
    bool? memory,
  }) : super(_openConnection(memory ?? true));

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection(bool memory) {
  if (memory) {
    return LazyDatabase(() async {
      return NativeDatabase.memory();
    });
  }
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
