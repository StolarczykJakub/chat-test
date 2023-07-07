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
class ConversationsRepositoryImpl extends ConversationsRepository {
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
      final plainTextJson = await conversationsRemoteDataSource.getConversations();
      List<ConversationDto> conversationDtoList;
      if (isJSON(plainTextJson)) {
        conversationDtoList = json.decode(plainTextJson);
      } else {
        final fixedJsonResponse = fixJson(plainTextJson);
        conversationDtoList =
            fixedJsonResponse.map((conversationJson) => ConversationDto.fromJson(conversationJson)).toList();
      }

      return conversationDtoList.map((e) => mapConversationFromDto(e)).toList();
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Message>> getMessages(String id) async {
    try {
      final plainTextJson = await conversationsRemoteDataSource.getMessages(id);
      List<MessageDto> messageDtoList;
      if (isJSON(plainTextJson)) {
        messageDtoList = json.decode(plainTextJson);
      } else {
        final fixedJsonResponse = fixJson(plainTextJson);
        messageDtoList = fixedJsonResponse.map((conversationJson) => MessageDto.fromJson(conversationJson)).toList();
      }

      return messageDtoList.map((e) => mapMessageFromDto(e)).toList();
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }
}

/// Dirty hack remove comma on badly formatted response
List<dynamic> fixJson(String plainTextJson) {
  String trimmedJson = plainTextJson.substring(0, plainTextJson.lastIndexOf(','));
  final plainTextJsonWithoutComma = "$trimmedJson]"; // third from end is comma
  final fixedJsonResponse = jsonDecode(plainTextJsonWithoutComma) as List;

  return fixedJsonResponse;
}

bool isJSON(str) {
  try {
    jsonDecode(str);
  } catch (e) {
    return false;
  }
  return true;
}
