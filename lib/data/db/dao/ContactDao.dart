import 'package:floor/floor.dart';

import '../entities/UserContactDBEntity.dart';

@dao
abstract class ContactDao {
  // Note: Floor doesn't natively support FTS, consider alternatives for full-text search

  @Query('SELECT * FROM user_contact ORDER BY name')
  Future<List<UserContactDBEntity>> getAllContacts(); // Consider using Stream or async* for reactive data retrieval

  @Query('SELECT * FROM user_contact WHERE id = :contactId')
  Future<UserContactDBEntity?> getContactById(String contactId);

  @Query('SELECT * FROM user_contact WHERE numbers LIKE :query OR name LIKE :query')
  Future<List<UserContactDBEntity>> findContacts(String query); // Adjusted method name for clarity

  @insert
  Future<int> insertContact(UserContactDBEntity contact); // Replaced "insertOne" for consistency

  @update
  Future<int> updateContact(UserContactDBEntity contact); // Replaced "updateOne" for consistency
}