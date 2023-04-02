// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';

import 'package:be_fitness_app/core/service/enumservice/gender_service.dart';

// ignore: must_be_immutable
class CoachModel extends Equatable {
  String id;
  bool state;
  String userName;
  String email;
  String address;
  String profilePhoto;
  Gender gender;
  double totalRating;
  List<String> ratingCount;
  double ratingAverage;
  List<String> subscribers;
  CoachModel({
    required this.id,
    required this.state,
    required this.userName,
    required this.email,
    required this.address,
    required this.profilePhoto,
    required this.gender,
    required this.totalRating,
    required this.ratingCount,
    required this.ratingAverage,
    required this.subscribers,
  });

  @override
  List<Object> get props {
    return [
      id,
      state,
      userName,
      email,
      address,
      profilePhoto,
      gender,
      totalRating,
      ratingCount,
      ratingAverage,
      subscribers,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'state': state,
      'userName': userName,
      'email': email,
      'address': address,
      'profilePhoto': profilePhoto,
      'gender': gender,
      'totalRating': totalRating,
      'ratingCount': ratingCount,
      'ratingAverage': ratingAverage,
      'subscribers': subscribers,
    };
  }

  factory CoachModel.fromMap(Map<String, dynamic> map) {
    return CoachModel(
      id: map['id'] as String,
      state: map['state'] as bool,
      userName: map['userName'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      profilePhoto: map['profilePhoto'] as String,
      gender: GenderService().convertStringToEnum(map['gender'].toString()),
      totalRating: map['totalRating'] as double,
      ratingCount: List<String>.from(map['ratingCount'].map((e) => e)),
      ratingAverage: map['ratingAverage'] as double,
      subscribers: List<String>.from(map['subscribers'].map((e) => e)),
    );
  }
}
