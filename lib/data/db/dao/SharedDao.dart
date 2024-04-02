import 'package:floor/floor.dart';
import '../entities/CategoryDBEntity.dart';
import '../entities/SharedContactDBEntity.dart';
import '../entities/TagDBEntity.dart';

@dao
abstract class SharedDao {
  // Note: Floor doesn't natively support FTS, consider alternatives for full-text search

  // Replace this with a suitable strategy for full-text search in Floor
  @Query('SELECT * FROM shared_contact WHERE tags LIKE :tag ORDER BY name')
  Future<List<SharedContactDBEntity>> findSharedContactWithTag(String tag);

  @Query('SELECT * FROM shared_contact WHERE numbers LIKE :query OR name LIKE :query')
  Future<List<SharedContactDBEntity>> searchSharedContacts(String query);

  @Query('SELECT * FROM shared_contact ORDER BY name')
  Future<List<SharedContactDBEntity>> getAllSharedContacts();

  @Query('SELECT * FROM shared_contact WHERE id = :contactId')
  Future<SharedContactDBEntity?> findSharedContactWithId(String contactId);

  @insert
  Future<int> insertSharedContact(SharedContactDBEntity contact);

  @insert
  Future<int> insertTag(TagDBEntity tag); // Assuming TagDBEntity is defined

  @insert
  Future<int> insertCategory(CategoryDBEntity category); // Assuming CategoryDBEntity is defined

  @Query('SELECT * FROM shared_category WHERE id = :categoryId')
  Future<CategoryDBEntity?> getCategory(String categoryId);

  @Query('SELECT * FROM shared_category')
  Future<List<CategoryDBEntity>> getAllCategories();
}
