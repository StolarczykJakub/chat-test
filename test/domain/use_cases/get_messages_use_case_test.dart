import 'package:chat_programming_test/domain/conversations_repository.dart';
import 'package:chat_programming_test/domain/models/message.dart';
import 'package:chat_programming_test/domain/use_case/get_messages_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConversationsRepository extends Mock implements ConversationsRepository {}

class FakeMessage extends Fake implements Message {}

const conversationID = "99";

void main() {
  group('GetMessagesUseCase', () {
    late MockConversationsRepository mockConversationsRepository;
    late FakeMessage fakeMessage;
    late GetMessagesUseCase getMessagesUseCase;

    setUp(() {
      fakeMessage = FakeMessage();
      mockConversationsRepository = MockConversationsRepository();
      getMessagesUseCase = GetMessagesUseCase(mockConversationsRepository);
    });

    test('should return 4 messages', () async {
      when(() => mockConversationsRepository.getMessages(conversationID)).thenAnswer(
        (_) async => [
          fakeMessage,
          fakeMessage,
          fakeMessage,
          fakeMessage,
        ],
      );

      final result = await getMessagesUseCase(conversationID);

      expect(4, result.length);
      verify(() => mockConversationsRepository.getMessages(conversationID)).called(1);
    });
  });
}
