import 'package:json_annotation/json_annotation.dart';
part 'chat.g.dart';
@JsonSerializable()
class Chat {
  int id;
  @JsonKey(name: 'user_avatar')
  String userAvatar;

  @JsonKey(name: 'user_name')
  String userName;

  String messenger;

  @JsonKey(name: 'is_online')
  bool isOnline;

  @JsonKey(name: 'is_seen')
  bool isSeen;

  @JsonKey(name: 'new_mess')
  bool newMess;

  @JsonKey(name: 'is_news')
  bool isNews;

  @JsonKey(name: 'is_new_story')
  bool isNewStory;

  String story;

  Chat({
    this.id,this.userAvatar,this.userName,this.messenger,this.isOnline,this.isSeen,this.newMess,this.isNews,this.isNewStory,this.story
  });
  factory Chat.fromJson(Map<String,dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJSON() => _$ChatToJson(this);

}
