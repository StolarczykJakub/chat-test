import 'package:auto_route/auto_route.dart';
import 'package:chat_programming_test/domain/models/conversation.dart';
import 'package:chat_programming_test/presentation/pages/home_page_action.dart';
import 'package:chat_programming_test/presentation/pages/home_page_cubit.dart';
import 'package:chat_programming_test/presentation/pages/home_page_state.dart';
import 'package:chat_programming_test/presentation/router/main_router.dart';
import 'package:chat_programming_test/presentation/style/app_dimens.dart';
import 'package:chat_programming_test/presentation/style/app_gaps.dart';
import 'package:chat_programming_test/presentation/utils/extensions/int_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

@RoutePage()
class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<HomePageCubit>();
    final state = useBlocBuilder(cubit);
    final conversationList = (state as HomePageStateIdle).conversationList ?? [];

    useActionListener<HomePageAction>(
      cubit,
      (action) => {
        action.when(
          navigateToConversation: (conversation) => context.router.push(
            ConversationRoute(conversation: conversation),
          ),
          error: (errorMessage) => _handleError(errorMessage, context),
        )
      },
    );

    useEffect(
      () {
        cubit.init();
        return;
      },
      [cubit],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat App by Jakub S"),
      ),
      body: Column(
        children: [
          const AppGap.twelve(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.twelve),
              child: RefreshIndicator(
                onRefresh: () => cubit.getConversations(),
                child: ListView.builder(
                  itemCount: conversationList.length,
                  itemBuilder: (BuildContext context, int index) => _conversationItem(
                    conversationList[index],
                    cubit,
                  ),
                ),
              ),
            ),
          ),
          const AppGap.twelve(),
        ],
      ),
    );
  }

  Widget _conversationItem(Conversation conversation, HomePageCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.sixteen,
        vertical: AppDimens.eight,
      ),
      child: Card(
        elevation: AppDimens.four,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.twelve),
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.twelve),
          ),
          onTap: () => cubit.openConversation(conversation),
          splashColor: Colors.grey,
          child: ListTile(
            contentPadding: const EdgeInsets.all(AppDimens.sixteen),
            leading: CircleAvatar(
              child: Text(conversation.members.length.toString()),
            ),
            title: Text(
              conversation.topic,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(conversation.lastMessage * 4),
            trailing: Text(
              conversation.modifiedAt.formatTimestamp(),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ),
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
