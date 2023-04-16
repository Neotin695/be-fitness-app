
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AddressModel extends Equatable {
  String name;
  String postalCode;
  String country;
  String subLocality;
  String locality;
  AddressModel({
    required this.name,
    required this.postalCode,
    required this.country,
    required this.subLocality,
    required this.locality,
  });

  @override
  List<Object> get props {
    return [
      name,
      postalCode,
      country,
      subLocality,
      locality,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'postalCode': postalCode,
      'country': country,
      'subLocality': subLocality,
      'locality': locality,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      name: map['name'] as String,
      postalCode: map['postalCode'] as String,
      country: map['country'] as String,
      subLocality: map['subLocality'] as String,
      locality: map['locality'] as String,
    );
  }

}
