// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return Chat(
    id: json['id'] as int,
    userAvatar: json['user_avatar'] as String,
    userName: json['user_name'] as String,
    messenger: json['messenger'] as String,
    isOnline: json['is_online'] as bool,
    isSeen: json['is_seen'] as bool,
    newMess: json['new_mess'] as bool,
    isNews: json['new_mess'] as bool,
    isNewStory: json['is_new_story'] as bool,
    story: json['story'] as String,
  );
}

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'id': instance.id,
      'user_avatar': instance.userAvatar,
      'user_name': instance.userName,
      'messenger': instance.messenger,
      'is_online': instance.isOnline,
      'is_seen': instance.isSeen,
      'new_mess': instance.newMess,
      'is_news':instance.isNews,
      'is_new_story':instance.isNewStory,
      'story':instance.story
    };
