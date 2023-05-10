import 'package:equatable/equatable.dart';

import 'package:be_fitness_app/core/service/enumservice/target_muscles.dart';

// ignore: must_be_immutable
class ExcerciseModel extends Equatable {
  String name;
  String gifUrl;
  List<int> duration;
  TargetMuscles targetMuscles;
  ExcerciseModel({
    required this.name,
    required this.gifUrl,
    required this.duration,
    required this.targetMuscles,
  });

  @override
  List<Object> get props => [name, gifUrl, duration, targetMuscles];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'gifUrl': gifUrl,
      'duration': duration,
      'targetMuscles':
          TargetMusclesService().convertEnumToString(targetMuscles),
    };
  }

  factory ExcerciseModel.fromMap(Map<String, dynamic> map) {
    return ExcerciseModel(
      name: map['name'] as String,
      gifUrl: map['gifUrl'] as String,
      duration: List<int>.from(map['duration'].map((e) => e)),
      targetMuscles: TargetMusclesService()
          .convertStringToEnum(map['targetMuscles'] as String),
    );
  }
}
