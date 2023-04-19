import 'package:be_fitness_app/core/service/interfaces/enum_interface.dart';

enum MessageType {
  text,
  image,
  video,
  audio,
  document,
}

class MessageService extends EnumService<MessageType> {
  @override
  String convertEnumToString(MessageType enumType) {
    switch (enumType) {
      case MessageType.text:
        return 'text';
      case MessageType.image:
        return 'image';
      case MessageType.video:
        return 'video';
      case MessageType.audio:
        return 'audio';
      case MessageType.document:
        return 'document';
    }
  }

  @override
  MessageType convertStringToEnum(String enumName) {
    switch (enumName) {
      case 'text':
        return MessageType.text;
      case 'image':
        return MessageType.image;
      case 'video':
        return MessageType.video;
      case 'audio':
        return MessageType.audio;
      case 'document':
        return MessageType.document;
      default:
        return MessageType.text;
    }
  }
}
