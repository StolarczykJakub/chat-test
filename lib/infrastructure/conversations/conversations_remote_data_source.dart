import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'conversations_remote_data_source.g.dart';

@RestApi()
@injectable
abstract class ConversationsRemoteDataSource {
  @factoryMethod
  factory ConversationsRemoteDataSource(Dio dio) = _ConversationsRemoteDataSource;

  @GET('/inbox.json')
  Future<String> getConversations();

  @GET('/{id}.json')
  Future<String> getMessages(@Path() String id);
}
