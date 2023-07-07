import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_dto.g.dart';

@JsonSerializable()
class MessageDto {
  MessageDto(
    this.id,
    this.message,
    this.modifiedAt,
    this.sender,
  );

  final String id;
  final String message;
  @JsonKey(name: 'modified_at')
  final int modifiedAt;
  final String sender;

  factory MessageDto.fromJson(Map<String, dynamic> json) => _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);
}
