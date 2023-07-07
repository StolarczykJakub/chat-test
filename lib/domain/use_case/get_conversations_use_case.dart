import 'package:chat_programming_test/domain/conversations_repository.dart';
import 'package:chat_programming_test/domain/models/conversation.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetConversationsUseCase {
  GetConversationsUseCase(this.conversationRepository);

  final ConversationsRepository conversationRepository;

  Future<List<Conversation>> call() {
    return conversationRepository.getConversations();
  }
}
