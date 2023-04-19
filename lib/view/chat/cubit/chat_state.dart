part of 'chat_cubit.dart';

enum DeleteFor {
  me,
  aother,
}

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class MessageSentState extends ChatState {}

class MessageSentFailureState extends ChatState {
  final String message;
  const MessageSentFailureState({required this.message});
}

class MessageSeenState extends ChatState {}

class MessageUploadingState extends ChatState {}

class MessageDeletedState extends ChatState {
  final DeleteFor deleteFor;

  const MessageDeletedState({required this.deleteFor});
}
