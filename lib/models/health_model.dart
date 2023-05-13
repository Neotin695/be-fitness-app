// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class HealthModel extends Equatable {
  double calories;
  List<String> cautions;
  TotalNuration totalNuration;
  HealthModel({
    required this.calories,
    required this.cautions,
    required this.totalNuration,
  });

  @override
  List<Object> get props => [calories, cautions, totalNuration];

  factory HealthModel.fromMap(Map<String, dynamic> map) {
    return HealthModel(
      calories: double.parse(map['calories'].toString()),
      cautions: List<String>.from(map['cautions'].map((e) => e)),
      totalNuration:
          TotalNuration.fromMap(map['totalNutrients'] as Map<String, dynamic>),
    );
  }

  factory HealthModel.fromJson(String source) =>
      HealthModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

// ignore: must_be_immutable
class TotalNuration extends Equatable {
  Nutrient fat;
  Nutrient procnt;
  Nutrient chole;
  Nutrient na;
  Nutrient ca;
  Nutrient zn;
  Nutrient chocdf;
  TotalNuration({
    required this.fat,
    required this.procnt,
    required this.chole,
    required this.na,
    required this.ca,
    required this.zn,
    required this.chocdf,
  });

  @override
  List<Object> get props {
    return [
      fat,
      procnt,
      chole,
      na,
      ca,
      zn,
      chocdf,
    ];
  }

  factory TotalNuration.fromMap(Map<String, dynamic> map) {
    return TotalNuration(
      fat: Nutrient.fromMap(map['FAT'] as Map<String, dynamic>),
      procnt: Nutrient.fromMap(map['PROCNT'] as Map<String, dynamic>),
      chole: Nutrient.fromMap(map['CHOLE'] as Map<String, dynamic>),
      na: Nutrient.fromMap(map['NA'] as Map<String, dynamic>),
      ca: Nutrient.fromMap(map['CA'] as Map<String, dynamic>),
      zn: Nutrient.fromMap(map['ZN'] as Map<String, dynamic>),
      chocdf: Nutrient.fromMap(map['CHOCDF'] as Map<String, dynamic>),
    );
  }

  factory TotalNuration.fromJson(String source) =>
      TotalNuration.fromMap(json.decode(source) as Map<String, dynamic>);
}

// ignore: must_be_immutable
class Nutrient extends Equatable {
  String label;
  String unit;
  double quantity;
  Nutrient({
    required this.unit,
    required this.quantity,
    required this.label,
  });

  @override
  List<Object> get props => [unit, quantity];

  factory Nutrient.fromMap(Map<String, dynamic> map) {
    return Nutrient(
      unit: map['unit'] as String,
      label: map['label'] as String,
      quantity: map['quantity'] as double,
    );
  }

  factory Nutrient.fromJson(String source) =>
      Nutrient.fromMap(json.decode(source) as Map<String, dynamic>);
}
