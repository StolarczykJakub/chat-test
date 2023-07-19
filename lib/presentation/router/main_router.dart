import 'package:auto_route/auto_route.dart';
import 'package:chat_programming_test/presentation/router/main_router.gr.dart';


@AutoRouterConfig()
class MainRouter extends $MainRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  final List<AutoRoute> routes = [
    AdaptiveRoute(page: HomeRoute.page, path: '/'),
    AdaptiveRoute(page: ConversationRoute.page),
  ];
}
