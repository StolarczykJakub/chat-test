import 'package:chat_programming_test/domain/models/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_page_state.freezed.dart';

@freezed
class ConversationPageState with _$ConversationPageState {
  const factory ConversationPageState.idle({
    required List<Message>? messages,
    @Default(false) bool isTyping,
  }) = ConversationPageStateIdle;

  const factory ConversationPageState.loading() = ConversationPageStateLoading;
}
