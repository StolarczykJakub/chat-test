import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_dto.g.dart';

@JsonSerializable()
class ConversationDto {
  ConversationDto(
    this.id,
    this.lastMessage,
    this.members,
    this.topic,
    this.modifiedAt,
  );

  final String id;
  @JsonKey(name: 'last_message')
  final String lastMessage;
  final List<String> members;
  final String topic;
  @JsonKey(name: 'modified_at')
  final int modifiedAt;

  factory ConversationDto.fromJson(Map<String, dynamic> json) => _$ConversationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationDtoToJson(this);
}
