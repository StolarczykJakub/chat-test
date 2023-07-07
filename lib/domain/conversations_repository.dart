import 'package:chat_programming_test/domain/models/conversation.dart';
import 'package:chat_programming_test/domain/models/message.dart';

abstract class ConversationsRepository {
  Future<List<Conversation>> getConversations();
  Future<List<Message>> getMessages(String id);
}
