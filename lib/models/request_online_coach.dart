
// ignore_for_file: public_member_api_docs, sort_constructors_first
class RequestOnlineCoachModel {
  String nationalIdFrontImg;
  String nationalIdBakcImg;
  String certificateIdImg;
  String personalImg;

  String fulName;
  String birthDate;
  String nationalId;
  String ceritifcateId;
  RequestOnlineCoachModel({
    required this.nationalIdFrontImg,
    required this.nationalIdBakcImg,
    required this.certificateIdImg,
    required this.personalImg,
    required this.fulName,
    required this.birthDate,
    required this.nationalId,
    required this.ceritifcateId,
  });

 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nationalIdFrontImg': nationalIdFrontImg,
      'nationalIdBakcImg': nationalIdBakcImg,
      'certificateIdImg': certificateIdImg,
      'personalImg': personalImg,
      'fulName': fulName,
      'birthDate': birthDate,
      'nationalId': nationalId,
      'ceritifcateId': ceritifcateId,
    };
  }

  factory RequestOnlineCoachModel.fromMap(Map<String, dynamic> map) {
    return RequestOnlineCoachModel(
      nationalIdFrontImg: map['nationalIdFrontImg'] as String,
      nationalIdBakcImg: map['nationalIdBakcImg'] as String,
      certificateIdImg: map['certificateIdImg'] as String,
      personalImg: map['personalImg'] as String,
      fulName: map['fulName'] as String,
      birthDate: map['birthDate'] as String,
      nationalId: map['nationalId'] as String,
      ceritifcateId: map['ceritifcateId'] as String,
    );
  }
}
