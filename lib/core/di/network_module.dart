import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class NetworkModule {
  @LazySingleton()
  Dio dio() {
    final dio = Dio();
    dio.options = BaseOptions(
      baseUrl: "https://jefe-stg-media-bucket.s3.amazonaws.com/programming-test/api",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      responseType: ResponseType.plain, // Dirty temp hack for bad backend response
    );
    // dio.interceptors.add(
    //   InterceptorsWrapper(
    //       onError: ( dioError) => errorInterceptor(dioError)),
    // );
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );

    return dio;
  }
}
