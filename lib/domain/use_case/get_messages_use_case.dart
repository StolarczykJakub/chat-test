import 'package:chat_programming_test/domain/conversations_repository.dart';
import 'package:chat_programming_test/domain/models/message.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMessagesUseCase {
  GetMessagesUseCase(this.conversationRepository);

  final ConversationsRepository conversationRepository;

  Future<List<Message>> call(String id) {
    return conversationRepository.getMessages(id);
  }
}
