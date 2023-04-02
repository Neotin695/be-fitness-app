// ignore_for_file: public_member_api_docs, sort_constructors_first
class RequestOnlineCoachEntity {
  List<String> images;
  String fulName;
  String birthDate;
  int nationalId;

  RequestOnlineCoachEntity({
    required this.images,
    required this.fulName,
    required this.birthDate,
    required this.nationalId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'images': images,
      'fulName': fulName,
      'birthDate': birthDate,
      'nationalId': nationalId,
    };
  }

  factory RequestOnlineCoachEntity.fromMap(Map<String, dynamic> map) {
    return RequestOnlineCoachEntity(
      images: List<String>.from(map['images'].map((e) => e)),
      fulName: map['fulName'] as String,
      birthDate: map['birthDate'] as String,
      nationalId: map['nationalId'] as int,
    );
  }
}
