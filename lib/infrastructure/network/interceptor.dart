import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  //TODO: INTERCEPTOR FOR HANDLING ERROR
  // @override
  // FutureOr<dynamic> onError(DioError dioError) {
  //   if (dioError.message.contains("ERROR_001")) {
  //     // this will push a new route and remove all the routes that were present
  //     navigatorKey.currentState.pushNamedAndRemoveUntil(
  //         "/login", (Route<dynamic> route) => false);
  //   }
  //
  //   return dioError;
  // }
}