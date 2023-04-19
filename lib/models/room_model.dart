// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class RoomModel extends Equatable {
  String roomId;
  List<String> participantsId;
  RoomModel({
    required this.roomId,
    required this.participantsId,
  });

  @override
  List<Object> get props => [roomId, participantsId];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'participantsId': participantsId,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      roomId: map['roomId'] as String,
      participantsId: List<String>.from(map['participantsId'].map((e)=> e)),
    );
  }
}
