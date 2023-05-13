import 'package:equatable/equatable.dart';

import 'package:be_fitness_app/core/service/enumservice/gender_service.dart';
import 'package:be_fitness_app/models/address_model.dart';
import 'package:be_fitness_app/models/review_model.dart';

// ignore: must_be_immutable
class CoachModel extends Equatable {
  String id;
  bool state;
  bool isCoach;
  String userName;
  String token;
  String email;
  AddressModel address;
  String profilePhoto;
  Gender gender;
  double averageRate;
  String birthDate;
  String certificateId;
  String nationalId;

  List<String> subscribers;
  CoachModel({
    required this.id,
    required this.state,
    required this.isCoach,
    required this.userName,
    required this.token,
    required this.email,
    required this.address,
    required this.profilePhoto,
    required this.averageRate,
    required this.gender,
    required this.birthDate,
    required this.certificateId,
    required this.nationalId,
    required this.subscribers,
  });

  @override
  List<Object> get props {
    return [
      id,
      state,
      isCoach,
      userName,
      token,
      email,
      address,
      profilePhoto,
      gender,
      birthDate,
      certificateId,
      nationalId,
      token,
      averageRate,
      subscribers,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'state': state,
      'isCoach': isCoach,
      'userName': userName,
      'token': token,
      'email': email,
      'address': address.toMap(),
      'profilePhoto': profilePhoto,
      'gender': GenderService().convertEnumToString(gender),
      'birthDate': birthDate,
      'certificateId': certificateId,
      'nationalId': nationalId,
      'averageRate': averageRate,
      'subscribers': subscribers,
    };
  }

  factory CoachModel.fromMap(Map<String, dynamic> map) {
    return CoachModel(
      id: map['id'] as String,
      state: map['state'] as bool,
      isCoach: map['isCoach'] as bool,
      userName: map['userName'] as String,
      token: map['token'] as String,
      email: map['email'] as String,
      averageRate: double.parse(map['averageRate'].toString()),
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
      profilePhoto: map['profilePhoto'] as String,
      gender: GenderService().convertStringToEnum(map['gender'].toString()),
      birthDate: map['birthDate'] as String,
      certificateId: map['certificateId'] as String,
      nationalId: map['nationalId'] as String,
      subscribers: List<String>.from(map['subscribers'].map((e) => e)),
    );
  }

  CoachModel copyWith({
    String? id,
    bool? state,
    bool? isCoach,
    String? userName,
    String? token,
    String? email,
    AddressModel? address,
    String? profilePhoto,
    Gender? gender,
    String? birthDate,
    String? certificateId,
    String? nationalId,
    ReviewModel? rating,
    double? averageRate,
    List<String>? subscribers,
  }) {
    return CoachModel(
      id: id ?? this.id,
      state: state ?? this.state,
      isCoach: isCoach ?? this.isCoach,
      userName: userName ?? this.userName,
      token: token ?? this.token,
      averageRate: averageRate ?? this.averageRate,
      email: email ?? this.email,
      address: address ?? this.address,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      certificateId: certificateId ?? this.certificateId,
      nationalId: nationalId ?? this.nationalId,
      subscribers: subscribers ?? this.subscribers,
    );
  }
}
