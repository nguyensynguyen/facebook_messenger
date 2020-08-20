abstract class ChatEvent  {
  ChatEvent([List props = const []]) : super();
}
class LoadChat extends ChatEvent{}
class LoadMoreChat extends ChatEvent{}

class GetMessageEvent extends ChatEvent {}

class CreateMessageEvent extends ChatEvent {
  String mess;
  String img;
  CreateMessageEvent({this.mess,this.img});
}
