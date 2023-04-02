// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:be_fitness_app/core/service/enumservice/gender_service.dart';
import 'package:be_fitness_app/core/service/enumservice/level_service.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  String id;
  String userName;
  String email;
  String address;
  String profilePhoto;
  int age;
  int height;
  int weight;
  Gender gender;
  Level level;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.address,
    required this.profilePhoto,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.level,
  });

  @override
  List<Object> get props {
    return [
      id,
      userName,
      email,
      address,
      profilePhoto,
      age,
      height,
      weight,
      gender,
      level,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'email': email,
      'address': address,
      'profilePhoto': profilePhoto,
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
      'level': level,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      profilePhoto: map['profilePhoto'] as String,
      age: map['age'] as int,
      height: map['height'] as int,
      weight: map['weight'] as int,
      gender: GenderService().convertStringToEnum(map['gender'].toString()),
      level: LevelService().convertStringToEnum(map['level'].toString()),
    );
  }
}
