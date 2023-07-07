import 'package:chat_programming_test/domain/models/conversation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_page_action.freezed.dart';

@freezed
class HomePageAction with _$HomePageAction {
  const factory HomePageAction.error(String errorMsg) = HomePageActionError;

  const factory HomePageAction.navigateToConversation(Conversation conversation) = HomePageActionNavigateToConversation;
}
