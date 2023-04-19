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
      emit(MessageSentFailureState(
          message: 'No Internet,please connect to internet and try again'));
      return;
    }

    final roomModel = initRoomModel();
    final messageModel = initMessageModel();
    final chatModel = initChatModel();
    emit(MessageUploadingState());
    _store
        .collection('chatRooms')
        .doc(generateMessageId())
        .set(initRoomModel().toMap())
        .then((value) {
      _store
          .collection('chatRooms')
          .doc(generateRoomId())
          .collection('messages')
          .doc(initMessageModel().id)
          .set(initMessageModel().toMap());
    });

    _store
        .collection(LogicConst.users)
        .doc(receiverId)
        .collection('conversetions')
        .doc(generateRoomId())
        .set(initChatModel().toMap());

    _store
        .collection(LogicConst.users)
        .doc(_auth!.uid)
        .collection('conversetions')
        .doc(generateRoomId())
        .set(initChatModel().toMap())
        .then((value) => message.clear());
    emit(MessageSentState());
  }

  Future<bool> isConntected() async => await InternetService().isConnected();

  String generateRoomId() {
    if (_auth!.uid.codeUnits[0] < receiverId.codeUnits[0]) {
      return _auth!.uid + receiverId;
    } else {
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
        time: DateFormat('hh:MM').format(DateTime.now()),
        timestamp: FieldValue.serverTimestamp());
  }

  ChatModel initChatModel() {
    return ChatModel(
      chatRoomId: initRoomModel().roomId,
      userPhotoUrl: fetchUserData()['profilePhoto'].isEmpty
          ? ''
          : fetchUserData()['profilePhoto'],
      userName: fetchUserData()['userName'],
      messageModel: initMessageModel(),
    );
  }

  Map<String, dynamic> fetchUserData() {
    Map<String, dynamic> temp = {};
    _store
        .collection(LogicConst.users)
        .where('id', isEqualTo: receiverId)
        .get()
        .then((value) {
      temp = value.docs.first as Map<String, dynamic>;
    });
    return temp;
  }

  List<MessageModel> fetchMessages() {
    List<MessageModel> temp = [];
    _streamSubscription?.cancel();
    _streamSubscription = _store
        .collection('chatRooms')
        .doc(generateRoomId())
        .collection('messages')
        .orderBy('tempstamp')
        .snapshots()
        .listen((event) {
      temp = List<MessageModel>.from(
          event.docs.reversed.map((e) => MessageModel.fromMap(e.data())));
    });
    return temp;
  }

  String generateMessageId() =>
      _store.collection('chatRooms').doc('messages').collection('message').id;

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
