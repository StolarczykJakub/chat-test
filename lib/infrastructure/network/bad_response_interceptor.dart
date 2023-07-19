import 'dart:convert';

import 'package:chat_programming_test/presentation/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class BadResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    /// This is the solution to an (intentional?) wrong response from the backend
    /// Dirty hack remove comma on badly formatted response (inform backend about bad format)
    if (!isJSON(response.data)) {
      final fixedJsonResponse = _fixJson(response.data);
      final fixedResponse = Response(
        requestOptions: response.requestOptions,
        data: fixedJsonResponse,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isRedirect: response.isRedirect,
        redirects: response.redirects,
        extra: response.extra,
      );
      logger.w("** REPORT BROKEN RESPONSE TO BACKEND");
      logger.w("${response.data}");
      return handler.next(fixedResponse);
    }
    return handler.next(response);
  }

  String _fixJson(String plainTextJson) {
    String trimmedJson = plainTextJson.substring(0, plainTextJson.lastIndexOf(','));
    final plainTextJsonWithoutComma = "$trimmedJson]";

    return plainTextJsonWithoutComma;
  }

  bool isJSON(str) {
    try {
      jsonDecode(str);
    } catch (e) {
      return false;
    }
    return true;
  }
}
