import 'package:chat_programming_test/domain/models/conversation.dart';
import 'package:chat_programming_test/infrastructure/conversations/models/conversation_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConversationFromDtoMapper {
  ConversationFromDtoMapper();

  Conversation call(ConversationDto conversationDto) {
    return Conversation(
      id: conversationDto.id,
      lastMessage: conversationDto.lastMessage,
      members: conversationDto.members,
      topic: conversationDto.topic,
      modifiedAt: conversationDto.modifiedAt,
    );
  }
}
