import 'package:chat_programming_test/core/di/injector.dart';
import 'package:chat_programming_test/presentation/router/main_router.dart';
import 'package:flutter/material.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(
    HookedBlocConfigProvider(
      injector: () => getIt,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _mainRouter = MainRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _mainRouter.config(),
      title: 'Flutter Chat App',
    );
  }
}
