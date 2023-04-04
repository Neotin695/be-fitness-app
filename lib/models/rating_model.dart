// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class RatingModel extends Equatable {
  double totalRating;
  List<String> ratingCount;
  double ratingAverage;
  RatingModel({
    required this.totalRating,
    required this.ratingCount,
    required this.ratingAverage,
  });

  @override
  List<Object> get props => [totalRating, ratingCount, ratingAverage];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalRating': totalRating,
      'ratingCount': ratingCount,
      'ratingAverage': ratingAverage,
    };
  }

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      totalRating: double.parse(map['totalRating'].toString()),
      ratingCount: List<String>.from(map['ratingCount'].map((e) => e)),
      ratingAverage: double.parse(map['ratingAverage'].toString()),
    );
  }
}
