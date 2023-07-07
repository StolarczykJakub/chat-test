import 'package:chat_programming_test/domain/models/conversation.dart';
import 'package:chat_programming_test/infrastructure/conversations/mappers/conversation_mapper.dart';
import 'package:chat_programming_test/infrastructure/conversations/mappers/message_mapper.dart';
import 'package:chat_programming_test/infrastructure/conversations/models/conversation_dto.dart';
import 'package:chat_programming_test/infrastructure/conversations/models/message_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('MessagesFromDtoMapper', () {
    late MessageFromDtoMapper messagesFromDtoMapper;

    setUp(() {
      messagesFromDtoMapper = MessageFromDtoMapper();
    });

    test('should return Messages from MessagesDto', () {
      final conversationDto = MessageDto(
        '66',
        'message',
        1111,
        "sender",
      );

      final result = messagesFromDtoMapper(conversationDto);

      expect(result.id, conversationDto.id);
      expect(result.message, conversationDto.message);
      expect(result.modifiedAt, conversationDto.modifiedAt);
      expect(result.sender, conversationDto.sender);
    });
  });
}
