import 'package:chat_programming_test/domain/models/conversation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_page_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState.idle({required List<Conversation>? conversationList}) = HomePageStateIdle;

  const factory HomePageState.loading() = HomePageStateLoading;
}
