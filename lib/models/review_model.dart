// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ReviewModel extends Equatable {
  double totalRating;
  List<String> ratingCount;
  double ratingAverage;
  String textReview;
  String userName;
  String profilePhoto;
  ReviewModel({
    required this.totalRating,
    required this.ratingCount,
    required this.ratingAverage,
    required this.textReview,
    required this.userName,
    required this.profilePhoto,
  });

  @override
  List<Object> get props {
    return [
      totalRating,
      ratingCount,
      ratingAverage,
      textReview,
      userName,
      profilePhoto,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalRating': totalRating,
      'ratingCount': ratingCount,
      'ratingAverage': ratingAverage,
      'textReview': textReview,
      'userName': userName,
      'profilePhoto': profilePhoto,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      totalRating: map['totalRating'] as double,
      ratingCount: List<String>.from(map['ratingCount'].map((e) => e)),
      ratingAverage: map['ratingAverage'] as double,
      textReview: map['textReview'] as String,
      userName: map['userName'] as String,
      profilePhoto: map['profilePhoto'] as String,
    );
  }

  ReviewModel copyWith({
    double? totalRating,
    List<String>? ratingCount,
    double? ratingAverage,
    String? textReview,
    String? userName,
    String? profilePhoto,
  }) {
    return ReviewModel(
      totalRating: totalRating ?? this.totalRating,
      ratingCount: ratingCount ?? this.ratingCount,
      ratingAverage: ratingAverage ?? this.ratingAverage,
      textReview: textReview ?? this.textReview,
      userName: userName ?? this.userName,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
