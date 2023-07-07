import 'package:chat_programming_test/infrastructure/conversations/mappers/conversation_mapper.dart';
import 'package:chat_programming_test/infrastructure/conversations/models/conversation_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConversationFromDtoMapper', () {
    late ConversationFromDtoMapper conversationFromDtoMapper;

    setUp(() {
      conversationFromDtoMapper = ConversationFromDtoMapper();
    });

    test('should return Conversation from ConversationDto', () {
      final conversationDto = ConversationDto(
        '66',
        'lastMessage',
        ["aaa", "bbb"],
        "topic",
        1111,
      );

      final result = conversationFromDtoMapper(conversationDto);

      expect(result.id, conversationDto.id);
      expect(result.lastMessage, conversationDto.lastMessage);
      expect(result.members, conversationDto.members);
      expect(result.modifiedAt, conversationDto.modifiedAt);
      expect(result.topic, conversationDto.topic);
    });
  });
}
