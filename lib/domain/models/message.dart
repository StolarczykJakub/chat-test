import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String message,
    required int modifiedAt,
    required String sender,
  }) = _Message;
}