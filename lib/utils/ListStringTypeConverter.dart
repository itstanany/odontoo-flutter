import 'package:floor/floor.dart';

class ListStringTypeConverter extends TypeConverter<List<String>, String> {
  @override
  List<String> decode(String databaseValue) {
    // if (databaseValue == null) return null;

    // Ensure consistent comma-separated list format:
    return databaseValue
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(' ', '')
        .split(',');
  }

  @override
  String encode(List<String>? value) {
    if (value == null) return ''; // Handle null values gracefully
    return value.toString(); // Floor handles string representation for lists
  }
}
