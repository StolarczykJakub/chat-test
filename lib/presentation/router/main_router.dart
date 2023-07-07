import 'package:auto_route/auto_route.dart';
import 'package:chat_programming_test/domain/models/conversation.dart';
import 'package:chat_programming_test/presentation/pages/conversation/conversation_page.dart';
import 'package:chat_programming_test/presentation/pages/home_page.dart';

part 'main_router.gr.dart';

@AutoRouterConfig()
class MainRouter extends _$MainRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: HomeRoute.page, path: '/'),
    AutoRoute(page: ConversationRoute.page),
  ];
}
