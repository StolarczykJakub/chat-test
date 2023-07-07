import 'package:chat_programming_test/domain/models/conversation.dart';
import 'package:chat_programming_test/domain/use_case/get_conversations_use_case.dart';
import 'package:chat_programming_test/presentation/app_logger.dart';
import 'package:chat_programming_test/presentation/pages/home_page_action.dart';
import 'package:chat_programming_test/presentation/pages/home_page_state.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomePageCubit extends ActionCubit<HomePageState, HomePageAction> {
  HomePageCubit(
    this._getConversations,
  ) : super(const HomePageState.idle(conversationList: null));

  final GetConversationsUseCase _getConversations;

  void init() {
    getConversations();
  }

  Future<void> getConversations() async {
    emit(const HomePageState.idle(conversationList: null));

    try {
      final conversationList = await _getConversations();
      emit(
        HomePageState.idle(conversationList: conversationList),
      );
    } catch (e) {
      logger.e(e);
      dispatch(HomePageAction.error(e.toString()));
      emit( const HomePageState.idle(conversationList: null));
    }
  }

  void openConversation(Conversation conversation) {
    dispatch(HomePageAction.navigateToConversation(conversation));
  }
}
