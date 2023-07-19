import 'dart:convert';

import 'package:chat_programming_test/domain/conversations_repository.dart';
import 'package:chat_programming_test/domain/models/conversation.dart';
import 'package:chat_programming_test/domain/models/message.dart';
import 'package:chat_programming_test/infrastructure/conversations/conversations_remote_data_source.dart';
import 'package:chat_programming_test/infrastructure/conversations/mappers/conversation_mapper.dart';
import 'package:chat_programming_test/infrastructure/conversations/mappers/message_mapper.dart';
import 'package:chat_programming_test/infrastructure/conversations/models/conversation_dto.dart';
import 'package:chat_programming_test/infrastructure/conversations/models/message_dto.dart';
import 'package:chat_programming_test/presentation/app_logger.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ConversationsRepository)
class ConversationsRepositoryImpl implements ConversationsRepository {
  ConversationsRepositoryImpl(
    this.conversationsRemoteDataSource,
    this.mapConversationFromDto,
    this.mapMessageFromDto,
  );

  final ConversationsRemoteDataSource conversationsRemoteDataSource;
  final ConversationFromDtoMapper mapConversationFromDto;
  final MessageFromDtoMapper mapMessageFromDto;

  @override
  Future<List<Conversation>> getConversations() async {
    try {
      final responsePlainText = await conversationsRemoteDataSource.getConversations();
      final jsonResponse = jsonDecode(responsePlainText) as List;
      final conversationDtoList =
          jsonResponse.map((conversationJson) => ConversationDto.fromJson(conversationJson)).toList();

      return conversationDtoList.map((conversationDto) => mapConversationFromDto(conversationDto)).toList();
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Message>> getMessages(String id) async {
    try {
      final plainTextJson = await conversationsRemoteDataSource.getMessages(id);
      final jsonResponse = jsonDecode(plainTextJson) as List;
      final messageDtoList = jsonResponse.map((conversationJson) => MessageDto.fromJson(conversationJson)).toList();

      return messageDtoList.map((e) => mapMessageFromDto(e)).toList();
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }
}
