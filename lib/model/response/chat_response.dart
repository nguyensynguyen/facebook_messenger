import 'package:json_annotation/json_annotation.dart';
import '../chat.dart';
import 'api_response.dart';
part 'chat_response.g.dart';
@JsonSerializable()
class ChatResponse extends ApiResponse{
  List<Chat> data;
  ChatResponse({this.data});

  factory ChatResponse.fromJson(Map<String,dynamic> json) =>
      _$ChatResponseFromJson(json);

  Map<String, dynamic> toJSON() => _$ChatResponseToJson(this);
}
