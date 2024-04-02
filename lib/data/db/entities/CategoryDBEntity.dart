import 'package:floor/floor.dart';

@Entity(tableName: 'shared_category')
class CategoryDBEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'label')
  final String label;

  @ColumnInfo(name: 'tags')
  final List<String> tags;

  CategoryDBEntity({
    required this.id,
    required this.label,
    required this.tags,
  });
}
