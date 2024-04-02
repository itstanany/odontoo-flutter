// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorUserDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$UserDatabaseBuilder databaseBuilder(String name) =>
      _$UserDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$UserDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$UserDatabaseBuilder(null);
}

class _$UserDatabaseBuilder {
  _$UserDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$UserDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$UserDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<UserDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$UserDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$UserDatabase extends UserDatabase {
  _$UserDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ContactDao? _contactDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `user_contact` (`id` TEXT NOT NULL, `name` TEXT NOT NULL, `countryCodes` TEXT NOT NULL, `numbers` TEXT NOT NULL, `tags` TEXT NOT NULL, `note` TEXT NOT NULL, `profilePic` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ContactDao get contactDao {
    return _contactDaoInstance ??= _$ContactDao(database, changeListener);
  }
}

class _$ContactDao extends ContactDao {
  _$ContactDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userContactDBEntityInsertionAdapter = InsertionAdapter(
            database,
            'user_contact',
            (UserContactDBEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'countryCodes':
                      _listStringTypeConverter.encode(item.countryCodes),
                  'numbers': _listStringTypeConverter.encode(item.numbers),
                  'tags': _listStringTypeConverter.encode(item.tags),
                  'note': item.note,
                  'profilePic': item.profilePic
                }),
        _userContactDBEntityUpdateAdapter = UpdateAdapter(
            database,
            'user_contact',
            ['id'],
            (UserContactDBEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'countryCodes':
                      _listStringTypeConverter.encode(item.countryCodes),
                  'numbers': _listStringTypeConverter.encode(item.numbers),
                  'tags': _listStringTypeConverter.encode(item.tags),
                  'note': item.note,
                  'profilePic': item.profilePic
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserContactDBEntity>
      _userContactDBEntityInsertionAdapter;

  final UpdateAdapter<UserContactDBEntity> _userContactDBEntityUpdateAdapter;

  @override
  Future<List<UserContactDBEntity>> getAllContacts() async {
    return _queryAdapter.queryList('SELECT * FROM user_contact ORDER BY name',
        mapper: (Map<String, Object?> row) => UserContactDBEntity(
            id: row['id'] as String,
            name: row['name'] as String,
            countryCodes:
                _listStringTypeConverter.decode(row['countryCodes'] as String),
            numbers: _listStringTypeConverter.decode(row['numbers'] as String),
            tags: _listStringTypeConverter.decode(row['tags'] as String),
            note: row['note'] as String,
            profilePic: row['profilePic'] as String?));
  }

  @override
  Future<UserContactDBEntity?> getContactById(String contactId) async {
    return _queryAdapter.query('SELECT * FROM user_contact WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserContactDBEntity(
            id: row['id'] as String,
            name: row['name'] as String,
            countryCodes:
                _listStringTypeConverter.decode(row['countryCodes'] as String),
            numbers: _listStringTypeConverter.decode(row['numbers'] as String),
            tags: _listStringTypeConverter.decode(row['tags'] as String),
            note: row['note'] as String,
            profilePic: row['profilePic'] as String?),
        arguments: [contactId]);
  }

  @override
  Future<List<UserContactDBEntity>> findContacts(String query) async {
    return _queryAdapter.queryList(
        'SELECT * FROM user_contact WHERE numbers LIKE ?1 OR name LIKE ?1',
        mapper: (Map<String, Object?> row) => UserContactDBEntity(
            id: row['id'] as String,
            name: row['name'] as String,
            countryCodes:
                _listStringTypeConverter.decode(row['countryCodes'] as String),
            numbers: _listStringTypeConverter.decode(row['numbers'] as String),
            tags: _listStringTypeConverter.decode(row['tags'] as String),
            note: row['note'] as String,
            profilePic: row['profilePic'] as String?),
        arguments: [query]);
  }

  @override
  Future<int> insertContact(UserContactDBEntity contact) {
    return _userContactDBEntityInsertionAdapter.insertAndReturnId(
        contact, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateContact(UserContactDBEntity contact) {
    return _userContactDBEntityUpdateAdapter.updateAndReturnChangedRows(
        contact, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _listStringTypeConverter = ListStringTypeConverter();
