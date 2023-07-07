import 'package:freezed_annotation/freezed_annotation.dart';

part  'conversation_page_action.freezed.dart';

@freezed
class ConversationPageAction with _$ConversationPageAction {

  const factory ConversationPageAction.error(String errorMsg) = ConversationPageActionError;

}