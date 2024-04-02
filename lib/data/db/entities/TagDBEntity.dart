import 'package:floor/floor.dart';

@Entity(tableName: 'shared_tag')
class TagDBEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'label')
  final String label;

  TagDBEntity({
    required this.id,
    required this.label,
  });
}