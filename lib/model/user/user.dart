import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? age;
  @HiveField(2)
  String? phone;
  @HiveField(3)
  String? imagePath;

  User({
    required this.name,
    required this.age,
    required this.phone,
    required this.imagePath,
  });
}
