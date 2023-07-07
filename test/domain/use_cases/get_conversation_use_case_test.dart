import 'package:chat_programming_test/domain/conversations_repository.dart';
import 'package:chat_programming_test/domain/models/conversation.dart';
import 'package:chat_programming_test/domain/use_case/get_conversations_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConversationsRepository extends Mock implements ConversationsRepository {}

class FakeConversation extends Fake implements Conversation {}

void main() {
  group('GetConversationsUseCase', () {
    late MockConversationsRepository mockConversationsRepository;
    late FakeConversation fakeConversation;
    late GetConversationsUseCase getConversationsUseCase;

    setUp(() {
      fakeConversation = FakeConversation();
      mockConversationsRepository = MockConversationsRepository();
      getConversationsUseCase = GetConversationsUseCase(mockConversationsRepository);
    });

    test('should return 3 conversations', () async {
      when(() => mockConversationsRepository.getConversations()).thenAnswer(
        (_) async => [
          fakeConversation,
          fakeConversation,
          fakeConversation,
        ],
      );

      final result = await getConversationsUseCase();

      expect(3, result.length);
      verify(() => mockConversationsRepository.getConversations()).called(1);
    });
  });
}
