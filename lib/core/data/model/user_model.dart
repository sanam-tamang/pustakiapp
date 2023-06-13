import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    super.image,
    super.isAdmin,
    super.isActive,
    super.lastLogin,
    super.createdAt,
  });

  Map<String, dynamic> tomap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      image: map['image'],
      isAdmin: map['is_admin'],
      isActive: map['is_active'],
      lastLogin: map['last_login'],
      createdAt: map['created_at'],
    );
  }
}
