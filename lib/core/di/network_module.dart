import 'package:chat_programming_test/infrastructure/network/bad_response_interceptor.dart';
import 'package:chat_programming_test/infrastructure/network/pretty_dio_logger_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @LazySingleton()
  Dio dio(BadResponseInterceptor badResponseInterceptor) {
    final dio = Dio();
    dio.options = BaseOptions(
      baseUrl: "https://jefe-stg-media-bucket.s3.amazonaws.com/programming-test/api",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      responseType: ResponseType.plain, // Dirty temp hack for bad backend response
    );
    dio.interceptors.addAll([
      dioLogger,
      badResponseInterceptor,
    ]);

    return dio;
  }
}
