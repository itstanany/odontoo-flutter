import 'package:floor/floor.dart';

@Entity(tableName: 'shared_contact')
class SharedContactDBEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'country_codes') // Adjusted column name for better compatibility
  final List<String> countryCodes;

  @ColumnInfo(name: 'numbers')
  final List<String> numbers;

  @ColumnInfo(name: 'tags')
  final List<String> tags;

  @ColumnInfo(name: 'note')
  final String note;

  @ColumnInfo(name: 'profile_pic') // Adjusted column name for better compatibility
  final String? profilePic;

  SharedContactDBEntity({
    required this.id,
    required this.name,
    required this.countryCodes,
    required this.numbers,
    required this.tags,
    required this.note,
    this.profilePic,
  });
}
