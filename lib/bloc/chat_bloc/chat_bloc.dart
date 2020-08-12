import 'dart:core' as prefix0;
import 'dart:core';
import 'package:fb_login_google/model/chat.dart';
import 'package:fb_login_google/provider/chat_provider.dart';
import 'package:bloc/bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<Chat> listData = [];
  String nextUrl = '';

  ChatProvider _chatProvider = new ChatProvider();

  ChatBloc() : super(InitalChat());

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is LoadChat) {
      if (state is InitalChat) {
        yield ChatLoading();
        var response = await _chatProvider.getListChat();
        if (response.status == "success") {
          this.listData = response.data;
          //  nextUrl = response.nextUrl;
          yield ChatLoaded();
        }
      }
    }

    if (event is LoadMoreChat) {
      var res = await _chatProvider.getListChat();
      if (res == null) {}
      this.listData = listData + res.data;
      yield ChatLoaded();
    }
  }
}
