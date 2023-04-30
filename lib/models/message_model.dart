// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../core/service/enumservice/message_type.dart';

class MessageModel extends Equatable {
  String id;
  String message;
  String? caption;
  String senderId;
  String receiverId;
  String time;
  bool isSeen;
  MessageType messageType;
  FieldValue? timestamp;
  MessageModel({
    required this.id,
    required this.message,
    this.caption,
    required this.senderId,
    required this.receiverId,
    required this.messageType,
    required this.isSeen,
    this.timestamp,
    required this.time,
  });

  @override
  List<Object> get props {
    return [
      id,
      message,
      caption!,
      senderId,
      receiverId,
      messageType,
      isSeen,
      timestamp!,
      time,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'caption': caption,
      'senderId': senderId,
      'receiverId': receiverId,
      'messageType': MessageService().convertEnumToString(messageType),
      'isSeen': isSeen,
      'timestamp': timestamp,
      'time': time,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as String,
      message: map['message'] as String,
      caption: map['caption'] != null ? map['caption'] as String : null,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      messageType:
          MessageService().convertStringToEnum(map['messageType'].toString()),
      isSeen: map['isSeen'] as bool,
      time: map['time'] as String,
    );
  }
}
