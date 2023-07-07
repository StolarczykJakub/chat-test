import 'package:chat_programming_test/domain/models/conversation.dart';
import 'package:chat_programming_test/domain/models/message.dart';
import 'package:chat_programming_test/domain/use_case/get_messages_use_case.dart';
import 'package:chat_programming_test/presentation/app_logger.dart';
import 'package:chat_programming_test/presentation/pages/conversation/conversation_page_action.dart';
import 'package:chat_programming_test/presentation/pages/conversation/conversation_page_state.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConversationPageCubit extends ActionCubit<ConversationPageState, ConversationPageAction> {
  ConversationPageCubit(
    this._getMessages,
  ) : super(const ConversationPageState.loading());

  final GetMessagesUseCase _getMessages;
  late Conversation _conversation;
  List<Message> _messages = [];

  void init(Conversation conversation) {
    _conversation = conversation;
    getConversations();
  }

  Future<void> getConversations() async {
    emit(const ConversationPageState.loading());

    try {
      _messages = await _getMessages(_conversation.id);
      logger.d(_messages);
      emit(ConversationPageState.idle(messages: _messages));
    } catch (e) {
      logger.e(e);
      dispatch(ConversationPageAction.error(e.toString()));
      emit(const ConversationPageState.idle(messages: null));
    }
  }

  void sendMessage(String text) {
    final messageCreationDate = DateTime.now().millisecondsSinceEpoch;
    _messages.add(
      Message(
        id: "663",
        message: text,
        modifiedAt: int.parse(messageCreationDate.toString()),
        sender: "Me",
      ),
    );
    emit(const ConversationPageState.loading()); //TODO: REMOVE THIS ( TEMP TO FORCE REBUILD)
    emit(ConversationPageState.idle(messages: _messages));

    _mockSenderResponse();
  }

  Future<void> _mockSenderResponse() async {
    emit(ConversationPageState.idle(messages: _messages, isTyping: true));

    /// We will get message from random sender :D
    final senders = _messages
        .where(
          (element) => element.sender != "Me",
        )
        .map((e) => e.sender)
        .toList();
    senders.shuffle();

    await Future.delayed(const Duration(seconds: 2), () {
      final messageCreationDate = DateTime.now().millisecondsSinceEpoch;
      _messages.add(
        Message(
          id: "999",
          message: "Ok, no problem. :) Pizza on the way.",
          modifiedAt: int.parse(messageCreationDate.toString()),
          sender: senders.first,
        ),
      );
    });

    emit(ConversationPageState.idle(messages: _messages));
  }
}
