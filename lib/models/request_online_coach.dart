// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:be_fitness_app/models/address_model.dart';

class RequestOnlineCoachModel {
  String nationalIdFrontImg;
  String nationalIdBakcImg;
  String certificateIdImg;
  String personalImg;

  String userId;

  String fulName;
  String birthDate;
  String nationalId;
  String certificateId;
  AddressModel address;
  RequestOnlineCoachModel({
    required this.nationalIdFrontImg,
    required this.nationalIdBakcImg,
    required this.certificateIdImg,
    required this.personalImg,
    required this.userId,
    required this.fulName,
    required this.birthDate,
    required this.nationalId,
    required this.certificateId,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nationalIdFrontImg': nationalIdFrontImg,
      'nationalIdBakcImg': nationalIdBakcImg,
      'certificateIdImg': certificateIdImg,
      'personalImg': personalImg,
      'userId': userId,
      'fulName': fulName,
      'birthDate': birthDate,
      'nationalId': nationalId,
      'ceritifcateId': certificateId,
      'address': address.toMap(),
    };
  }

  factory RequestOnlineCoachModel.fromMap(Map<String, dynamic> map) {
    return RequestOnlineCoachModel(
        nationalIdFrontImg: map['nationalIdFrontImg'] as String,
        nationalIdBakcImg: map['nationalIdBakcImg'] as String,
        certificateIdImg: map['certificateIdImg'] as String,
        personalImg: map['personalImg'] as String,
        userId: map['userId'],
        fulName: map['fulName'] as String,
        birthDate: map['birthDate'] as String,
        nationalId: map['nationalId'] as String,
        certificateId: map['ceritifcateId'] as String,
        address: AddressModel.fromMap(map['address']));
  }
}
