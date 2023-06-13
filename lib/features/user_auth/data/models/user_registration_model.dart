

import '../../domain/entities/user_registration.dart';

class UserRegistrationModel extends UserRegistration {
  const UserRegistrationModel(
      {
      required super.email,
      required super.firstName,
      required super.lastName,
      super.image,
      required super.password});



  factory UserRegistrationModel.fromMap(Map<String, dynamic> map) {
    return UserRegistrationModel(
    
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      image: map['image'], password: '',
     
    );
  }
}
