import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
import '../../utils/ListStringTypeConverter.dart';
import 'dao/SharedDao.dart';
import 'entities/CategoryDBEntity.dart';
import 'entities/SharedContactDBEntity.dart';
import 'entities/TagDBEntity.dart';

part 'shared_database.g.dart';

// Remove FTS entities as Floor doesn't natively support FTS

@Database(version: 1, entities: [
  SharedContactDBEntity,
  CategoryDBEntity,
  TagDBEntity,
])
@TypeConverters([ListStringTypeConverter])
abstract class SharedDatabase extends FloorDatabase {
  SharedDao get sharedDao;
}
