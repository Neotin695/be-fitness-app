import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ReviewModel extends Equatable {
  String discriptionReview;
  String userName;
  String profilePhoto;
  String userId;
  double rate;
  String date;
  ReviewModel({
    required this.discriptionReview,
    required this.userName,
    required this.profilePhoto,
    required this.rate,
    required this.userId,
    required this.date,
  });

  @override
  List<Object> get props {
    return [
      discriptionReview,
      userName,
      profilePhoto,
      rate,
      userId,
      date,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'discriptionReview': discriptionReview,
      'userName': userName,
      'profilePhoto': profilePhoto,
      'rate': rate,
      'userId': userId,
      'date': date,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      discriptionReview: map['discriptionReview'] as String,
      userName: map['userName'] as String,
      profilePhoto: map['profilePhoto'] as String,
      rate: map['rate'] as double,
      date: map['date'] as String,
      userId: map['userId'] as String,
    );
  }
}
