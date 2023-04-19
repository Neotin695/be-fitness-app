import 'package:equatable/equatable.dart';

import 'package:be_fitness_app/models/message_model.dart';

// ignore: must_be_immutable
class ChatModel extends Equatable {
  String chatRoomId;
  String userPhotoUrl;
  String userName;
  MessageModel messageModel;
  ChatModel({
    required this.chatRoomId,
    required this.userPhotoUrl,
    required this.userName,
    required this.messageModel,
  });

  @override
  List<Object> get props => [chatRoomId, userPhotoUrl, userName, messageModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatRoomId': chatRoomId,
      'userPhotoUrl': userPhotoUrl,
      'userName': userName,
      'messageModel': messageModel.toMap(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatRoomId: map['chatRoomId'] as String,
      userPhotoUrl: map['userPhotoUrl'] as String,
      userName: map['userName'] as String,
      messageModel:
          MessageModel.fromMap(map['messageModel'] as Map<String, dynamic>),
    );
  }
}
