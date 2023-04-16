import 'package:be_fitness_app/models/address_model.dart';
import 'package:be_fitness_app/models/rating_model.dart';
import 'package:equatable/equatable.dart';

import 'package:be_fitness_app/core/service/enumservice/gender_service.dart';

// ignore: must_be_immutable
class CoachModel extends Equatable {
  String id;
  bool state;
  String userName;
  String email;
  String birthDate;
  String profilePhoto;
  String certificateId;
  String nationalId;
  List<String> subscribers;
  AddressModel address;
  RatingModel rating;
  Gender gender;
  CoachModel({
    required this.id,
    required this.state,
    required this.userName,
    required this.email,
    required this.birthDate,
    required this.address,
    required this.certificateId,
    required this.nationalId,
    required this.profilePhoto,
    required this.gender,
    required this.rating,
    required this.subscribers,
  });

  @override
  List<Object> get props {
    return [
      id,
      state,
      userName,
      email,
      birthDate,
      address,
      certificateId,
      nationalId,
      profilePhoto,
      gender,
      rating,
      subscribers,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'state': state,
      'userName': userName,
      'email': email,
      'birthDate': birthDate,
      'certificateId': certificateId,
      'nationalId': nationalId,
      'address': address.toMap(),
      'profilePhoto': profilePhoto,
      'gender': GenderService().convertEnumToString(gender),
      'rating': rating.toMap(),
      'subscribers': subscribers,
    };
  }

  factory CoachModel.fromMap(Map<String, dynamic> map) {
    return CoachModel(
      id: map['id'] as String,
      state: map['state'] as bool,
      userName: map['userName'] as String,
      email: map['email'] as String,
      birthDate: map['birthDate'],
      nationalId: map['nationalId'] as String,
      certificateId: map['certificateId'] as String,
      address: AddressModel.fromMap(map['address']),
      profilePhoto: map['profilePhoto'] as String,
      gender: GenderService().convertStringToEnum(map['gender'].toString()),
      rating: RatingModel.fromMap(map['rating']),
      subscribers: List<String>.from(map['subscribers'].map((e) => e)),
    );
  }
}
