
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required String lastMessage,
    required List<String> members,
    required  String topic,
    required int modifiedAt,
  }) = _Conversation;
}