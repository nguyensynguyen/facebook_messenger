abstract class ChatEvent  {
  ChatEvent([List props = const []]) : super();
}
class LoadChat extends ChatEvent{}
class LoadMoreChat extends ChatEvent{}
