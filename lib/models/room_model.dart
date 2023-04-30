
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
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
