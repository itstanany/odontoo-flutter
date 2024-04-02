// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorSharedDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$SharedDatabaseBuilder databaseBuilder(String name) =>
      _$SharedDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$SharedDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$SharedDatabaseBuilder(null);
}

class _$SharedDatabaseBuilder {
  _$SharedDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$SharedDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$SharedDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<SharedDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$SharedDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$SharedDatabase extends SharedDatabase {
  _$SharedDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  SharedDao? _sharedDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `shared_contact` (`id` TEXT NOT NULL, `name` TEXT NOT NULL, `country_codes` TEXT NOT NULL, `numbers` TEXT NOT NULL, `tags` TEXT NOT NULL, `note` TEXT NOT NULL, `profile_pic` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `shared_category` (`id` TEXT NOT NULL, `label` TEXT NOT NULL, `tags` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `shared_tag` (`id` TEXT NOT NULL, `label` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SharedDao get sharedDao {
    return _sharedDaoInstance ??= _$SharedDao(database, changeListener);
  }
}

class _$SharedDao extends SharedDao {
  _$SharedDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _sharedContactDBEntityInsertionAdapter = InsertionAdapter(
            database,
            'shared_contact',
            (SharedContactDBEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'country_codes':
                      _listStringTypeConverter.encode(item.countryCodes),
                  'numbers': _listStringTypeConverter.encode(item.numbers),
                  'tags': _listStringTypeConverter.encode(item.tags),
                  'note': item.note,
                  'profile_pic': item.profilePic
                }),
        _tagDBEntityInsertionAdapter = InsertionAdapter(
            database,
            'shared_tag',
            (TagDBEntity item) =>
                <String, Object?>{'id': item.id, 'label': item.label}),
        _categoryDBEntityInsertionAdapter = InsertionAdapter(
            database,
            'shared_category',
            (CategoryDBEntity item) => <String, Object?>{
                  'id': item.id,
                  'label': item.label,
                  'tags': _listStringTypeConverter.encode(item.tags)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SharedContactDBEntity>
      _sharedContactDBEntityInsertionAdapter;

  final InsertionAdapter<TagDBEntity> _tagDBEntityInsertionAdapter;

  final InsertionAdapter<CategoryDBEntity> _categoryDBEntityInsertionAdapter;

  @override
  Future<List<SharedContactDBEntity>> findSharedContactWithTag(
      String tag) async {
    return _queryAdapter.queryList(
        'SELECT * FROM shared_contact WHERE tags LIKE ?1 ORDER BY name',
        mapper: (Map<String, Object?> row) => SharedContactDBEntity(
            id: row['id'] as String,
            name: row['name'] as String,
            countryCodes:
                _listStringTypeConverter.decode(row['country_codes'] as String),
            numbers: _listStringTypeConverter.decode(row['numbers'] as String),
            tags: _listStringTypeConverter.decode(row['tags'] as String),
            note: row['note'] as String,
            profilePic: row['profile_pic'] as String?),
        arguments: [tag]);
  }

  @override
  Future<List<SharedContactDBEntity>> searchSharedContacts(String query) async {
    return _queryAdapter.queryList(
        'SELECT * FROM shared_contact WHERE numbers LIKE ?1 OR name LIKE ?1',
        mapper: (Map<String, Object?> row) => SharedContactDBEntity(
            id: row['id'] as String,
            name: row['name'] as String,
            countryCodes:
                _listStringTypeConverter.decode(row['country_codes'] as String),
            numbers: _listStringTypeConverter.decode(row['numbers'] as String),
            tags: _listStringTypeConverter.decode(row['tags'] as String),
            note: row['note'] as String,
            profilePic: row['profile_pic'] as String?),
        arguments: [query]);
  }

  @override
  Future<List<SharedContactDBEntity>> getAllSharedContacts() async {
    return _queryAdapter.queryList('SELECT * FROM shared_contact ORDER BY name',
        mapper: (Map<String, Object?> row) => SharedContactDBEntity(
            id: row['id'] as String,
            name: row['name'] as String,
            countryCodes:
                _listStringTypeConverter.decode(row['country_codes'] as String),
            numbers: _listStringTypeConverter.decode(row['numbers'] as String),
            tags: _listStringTypeConverter.decode(row['tags'] as String),
            note: row['note'] as String,
            profilePic: row['profile_pic'] as String?));
  }

  @override
  Future<SharedContactDBEntity?> findSharedContactWithId(
      String contactId) async {
    return _queryAdapter.query('SELECT * FROM shared_contact WHERE id = ?1',
        mapper: (Map<String, Object?> row) => SharedContactDBEntity(
            id: row['id'] as String,
            name: row['name'] as String,
            countryCodes:
                _listStringTypeConverter.decode(row['country_codes'] as String),
            numbers: _listStringTypeConverter.decode(row['numbers'] as String),
            tags: _listStringTypeConverter.decode(row['tags'] as String),
            note: row['note'] as String,
            profilePic: row['profile_pic'] as String?),
        arguments: [contactId]);
  }

  @override
  Future<CategoryDBEntity?> getCategory(String categoryId) async {
    return _queryAdapter.query('SELECT * FROM shared_category WHERE id = ?1',
        mapper: (Map<String, Object?> row) => CategoryDBEntity(
            id: row['id'] as String,
            label: row['label'] as String,
            tags: _listStringTypeConverter.decode(row['tags'] as String)),
        arguments: [categoryId]);
  }

  @override
  Future<List<CategoryDBEntity>> getAllCategories() async {
    return _queryAdapter.queryList('SELECT * FROM shared_category',
        mapper: (Map<String, Object?> row) => CategoryDBEntity(
            id: row['id'] as String,
            label: row['label'] as String,
            tags: _listStringTypeConverter.decode(row['tags'] as String)));
  }

  @override
  Future<int> insertSharedContact(SharedContactDBEntity contact) {
    return _sharedContactDBEntityInsertionAdapter.insertAndReturnId(
        contact, OnConflictStrategy.abort);
  }

  @override
  Future<int> insertTag(TagDBEntity tag) {
    return _tagDBEntityInsertionAdapter.insertAndReturnId(
        tag, OnConflictStrategy.abort);
  }

  @override
  Future<int> insertCategory(CategoryDBEntity category) {
    return _categoryDBEntityInsertionAdapter.insertAndReturnId(
        category, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _listStringTypeConverter = ListStringTypeConverter();
