import 'dart:async';

import 'package:floor/floor.dart';

import '../../utils/ListStringTypeConverter.dart';
import 'dao/ContactDao.dart';
import 'entities/UserContactDBEntity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'user_database.g.dart';

// Remove UserContactDBFTSEntity as Floor doesn't natively support FTS

@Database(version: 1, entities: [UserContactDBEntity])
@TypeConverters([ListStringTypeConverter]) // Assuming ListStringTypeConverter is defined
abstract class UserDatabase extends FloorDatabase {
  ContactDao get contactDao;
}