import 'package:auto_route/auto_route.dart';
import 'package:chat_programming_test/domain/models/conversation.dart';
import 'package:chat_programming_test/domain/models/message.dart';
import 'package:chat_programming_test/presentation/pages/conversation/conversation_page_action.dart';
import 'package:chat_programming_test/presentation/pages/conversation/conversation_page_cubit.dart';
import 'package:chat_programming_test/presentation/pages/conversation/conversation_page_state.dart';
import 'package:chat_programming_test/presentation/style/app_dimens.dart';
import 'package:chat_programming_test/presentation/style/app_gaps.dart';
import 'package:chat_programming_test/presentation/utils/extensions/int_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

@RoutePage()
class ConversationPage extends HookWidget {
  // ignore: use_key_in_widget_constructors
  const ConversationPage({
    required this.conversation,
  });

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<ConversationPageCubit>();
    final state = useBlocBuilder(cubit);

    useActionListener<ConversationPageAction>(
      cubit,
      (action) => {
        action.when(
          error: (errorMessage) => _handleError(errorMessage, context),
        )
      },
    );

    useEffect(
      () {
        cubit.init(conversation);
        return;
      },
      [cubit],
    );

    return Scaffold(
      appBar: AppBar(title: Text("Topic: ${conversation.topic}")),
      body: state.map(
        idle: (state) => _Idle(
          cubit: cubit,
          state: state,
          conversation: conversation,
        ),
        loading: (_) => const _Loading(),
      ),
    );
  }

  void _handleError(String errorMessage, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(errorMessage),
      ),
    );
  }
}

class _Idle extends HookWidget {
  const _Idle({
    Key? key,
    required this.cubit,
    required this.state,
    required this.conversation,
  }) : super(key: key);

  final ConversationPageCubit cubit;
  final ConversationPageStateIdle state;
  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    final messages = state.messages ?? [];
    final inputController = useTextEditingController();
    final scrollController = useScrollController();

    useEffect(() {
      if (scrollController.hasClients) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.jumpTo(
            scrollController.position.maxScrollExtent,
          );
        });
      }
    }, [messages.length]);

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: RefreshIndicator(
                  onRefresh: () => cubit.getConversations(),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final isLast = index == messages.length - 1;
                      return _messageItem(messages[index], isLast);
                    },
                  ),
                ),
              ),
              if (state.isTyping) ...[
                const Positioned(
                  bottom: 0,
                  child: _IsTyping(),
                ),
              ],
            ],
          ),
        ),
        _MessageInput(
          inputController: inputController,
          cubit: cubit,
        ),
      ],
    );
  }

  Widget _messageItem(
    Message message,
    bool isLast,
  ) {
    bool isMe = message.sender == 'Me';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.sixteen,
        vertical: AppDimens.eight,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe) ...[
                CircleAvatar(
                  child: Text(message.sender[0]),
                ),
              ],
              const AppGap.eight(),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(AppDimens.twelve),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blue : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(AppDimens.sixteen),
                  ),
                  child: Column(
                    crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.sender,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isMe ? Colors.white : Colors.black,
                        ),
                      ),
                      const AppGap.four(),
                      Text(
                        message.message,
                        style: TextStyle(color: isMe ? Colors.white : Colors.black),
                      ),
                      const AppGap.four(),
                      Text(
                        message.modifiedAt.formatTimestamp(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: isMe ? Colors.white70 : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isMe) ...[
                const AppGap.twentyFour(),
              ],
            ],
          ),
          if (state.isTyping && isLast) ...[
            const AppGap.fortyEight(),
          ],
        ],
      ),
    );
  }
}

/// Those widgets can be moved to separate file of course, depends on preference

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: Colors.blueAccent),
    );
  }
}

class _IsTyping extends StatelessWidget {
  const _IsTyping({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.eight,
        horizontal: AppDimens.sixteen,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CircleAvatar(),
          const AppGap.eight(),
          Container(
            padding: const EdgeInsets.all(AppDimens.twelve),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(AppDimens.sixteen),
            ),
            child: const Text(
              'is typing...',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  const _MessageInput({
    required this.inputController,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  final TextEditingController inputController;
  final ConversationPageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: AppDimens.one,
          color: Colors.black45,
        ),
        Padding(
          padding: const EdgeInsets.all(AppDimens.twenty),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  autofocus: true,
                  controller: inputController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimens.twenty),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: AppDimens.sixteen),
                  ),
                ),
              ),
              const AppGap.eight(),
              FloatingActionButton.small(
                onPressed: () {
                  cubit.sendMessage(inputController.text);
                  inputController.clear();
                },
                child: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
