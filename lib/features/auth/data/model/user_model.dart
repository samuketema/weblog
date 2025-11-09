import 'package:weblog/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.name, required super.email, required super.id});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? " ", 
      email: map['email'] ?? " ", 
      id: map['id']?? "");
  }
}
