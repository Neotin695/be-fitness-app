import 'package:be_fitness_app/models/address_model.dart';
import 'package:equatable/equatable.dart';

import 'package:be_fitness_app/core/service/enumservice/gender_service.dart';
import 'package:be_fitness_app/core/service/enumservice/level_service.dart';

// ignore: must_be_immutable
class TraineeModel extends Equatable {
  String id;
  String userName;
  String email;
  AddressModel address;
  String profilePhoto;
  Gender gender;
  
  int age;
  double height;
  double weight;
  Level level;

  TraineeModel({
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
      'address': address.toMap(),
      'profilePhoto': profilePhoto,
      'age': age,
      'height': height,
      'weight': weight,
      'gender': GenderService().convertEnumToString(gender),
      'level': LevelService().convertEnumToString(level),
    };
  }

  factory TraineeModel.fromMap(Map<String, dynamic> map) {
    return TraineeModel(
      id: map['id'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      address: AddressModel.fromMap(map['address']),
      profilePhoto: map['profilePhoto'] as String,
      age: int.parse(map['age'].toString()),
      height: double.parse(map['height'].toString()),
      weight: double.parse(map['weight'].toString()),
      gender: GenderService().convertStringToEnum(map['gender'].toString()),
      level: LevelService().convertStringToEnum(map['level'].toString()),
    );
  }
}
