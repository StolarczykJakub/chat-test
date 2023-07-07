import 'package:chat_programming_test/domain/models/message.dart';
import 'package:chat_programming_test/infrastructure/conversations/models/message_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class MessageFromDtoMapper {
  Message call(MessageDto messageDto) {
    return Message(
      id: messageDto.id,
      message: messageDto.message,
      modifiedAt: messageDto.modifiedAt,
      sender: messageDto.sender,
    );
  }
}
