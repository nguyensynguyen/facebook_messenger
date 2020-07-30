// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) {
  return ChatResponse(
    data: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Chat.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..status = json['status'] as String
    ..errorCode = json['errorCode'] as String
    ..message = json['message'] as String
    ..nextUrl = json['nextUrl'] as String;
}

Map<String, dynamic> _$ChatResponseToJson(ChatResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorCode': instance.errorCode,
      'message': instance.message,
      'nextUrl': instance.nextUrl,
      'data': instance.data,
    };
