import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final String? phoneNumber;

  @HiveField(2)
  final String? city;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  String? stock;

  UserModel({
    this.name,
    this.phoneNumber,
    this.city,
    this.image,
    this.stock,
  });
}
