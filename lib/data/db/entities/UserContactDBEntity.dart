import 'package:floor/floor.dart';


@Entity(tableName: 'user_contact')
class UserContactDBEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'countryCodes')
  final List<String> countryCodes;

  @ColumnInfo(name: 'numbers')
  final List<String> numbers;

  @ColumnInfo(name: 'tags')
   List<String> tags;

  @ColumnInfo(name: 'note')
  final String note;

  @ColumnInfo(name: 'profilePic')
  final String? profilePic;

  UserContactDBEntity({
    required this.id,
    required this.name,
    required this.countryCodes,
    required this.numbers,
    this.tags = const [],
    required this.note,
    this.profilePic,
  });
}
