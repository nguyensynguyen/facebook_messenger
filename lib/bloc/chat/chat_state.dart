abstract class ChatState{
  ChatState([List props = const []]) : super();
}
class InitalChat extends ChatState{}
class ChatLoading extends ChatState{}
class ChatLoadedErrors extends ChatState{}
class ChatLoaded extends ChatState{}
class loadingMoreChat extends ChatState{}
