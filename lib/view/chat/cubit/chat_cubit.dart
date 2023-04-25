import 'dart:async';

import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/core/service/enumservice/message_type.dart';
import 'package:be_fitness_app/core/service/internet_service.dart';
import 'package:be_fitness_app/models/chat_model.dart';
import 'package:be_fitness_app/models/message_model.dart';
import 'package:be_fitness_app/models/room_model.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  static ChatCubit get(context) => BlocProvider.of(context);
  ChatCubit() : super(ChatInitial());
  final TextEditingController message = TextEditingController();
  StreamSubscription? _streamSubscription;

  final _store = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance.currentUser;
  String receiverId = '';
  MessageType messageType = MessageType.text;

  Future<void> sendMessage() async {
    if (message.text.isEmpty) return;
    if (!await isConntected()) {
      emit(const MessageSentFailureState(
          message: 'No Internet,please connect to internet and try again'));
      return;
    }

    emit(MessageUploadingState());
    _store
        .collection('chatRooms')
        .doc(generateRoomId())
        .set(initRoomModel().toMap());

    _store
        .collection('chatRooms')
        .doc(generateRoomId())
        .collection('messages')
        .doc(generateMessageId())
        .set(initMessageModel().toMap());

    _store
        .collection(LogicConst.users)
        .doc(receiverId)
        .collection('conversetions')
        .doc(generateRoomId())
        .set((await initChatModel()).toMap());

    _store
        .collection(LogicConst.users)
        .doc(_auth!.uid)
        .collection('conversetions')
        .doc(generateRoomId())
        .set((await initChatModel()).toMap())
        .then((value) => message.clear());
    emit(MessageSentState());
  }

  Future<bool> isConntected() async => await InternetService().isConnected();

  String generateRoomId() {
    if (_auth!.uid.toLowerCase().codeUnits[0] <
        receiverId.toLowerCase().codeUnits[0]) {
      print(_auth!.uid + receiverId);
      return _auth!.uid + receiverId;
    } else {
      print(receiverId + _auth!.uid);
      return receiverId + _auth!.uid;
    }
  }

  RoomModel initRoomModel() {
    return RoomModel(
        roomId: generateRoomId(), participantsId: [_auth!.uid, receiverId]);
  }

  MessageModel initMessageModel() {
    return MessageModel(
        id: generateMessageId(),
        message: message.text,
        senderId: _auth!.uid,
        receiverId: receiverId,
        messageType: messageType,
        isSeen: false,
        time: DateFormat('hh:mm').format(DateTime.now()),
        timestamp: FieldValue.serverTimestamp());
  }

  Future<ChatModel> initChatModel() async {
    var userName = (await fetchUserData())['userName'];
    return ChatModel(
      chatRoomId: initRoomModel().roomId,
      userPhotoUrl: '',
      userName: userName,
      messageModel: initMessageModel(),
    );
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    Map<String, dynamic> temp = {};
    final data =
        await _store.collection(LogicConst.users).doc(receiverId).get();

    return data.data()!;
  }

  String generateMessageId() => _store
      .collection('chatRooms')
      .doc(generateRoomId())
      .collection('messages')
      .doc()
      .id;

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
