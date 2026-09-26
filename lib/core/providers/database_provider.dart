import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/db/app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
