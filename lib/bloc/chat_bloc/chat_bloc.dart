import 'dart:core';
import 'package:fb_login_google/bloc/app_bloc/app_bloc.dart';
import 'package:fb_login_google/contains/fire_store_name.dart';
import 'package:fb_login_google/model/chat.dart';
import 'package:fb_login_google/model/test_firebase.dart';
import 'package:fb_login_google/provider/chat_provider.dart';
import 'package:bloc/bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<Chat> listData = [];

  var mess = "mess";
  List<Room> roomId= [];
  String nextUrl = '';
  Firestore firestore = Firestore.instance;
  final AppBloc appBloc;
  ChatProvider chatProvider = new ChatProvider();
  List<DocumentSnapshot> documentSnapshot;
  var documentSnapshot1;

  ChatBloc({this.appBloc}) : super(InitalChat());

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is LoadChat) {
//      if (state is InitalChat) {
//        yield ChatLoading();
//        var response = await _chatProvider.getListChat();
//        if (response.status == "success") {
//          this.listData = response.data;
//          //  nextUrl = response.nextUrl;
//          yield ChatLoaded();
//        }
//      }
      yield ChatLoading();
      var chatRoomId = await firestore
          .collection(FireStoreName.RootCollectionUsers)
          .document(appBloc.profileData['uId'])
          .get();

      var listRoom = await firestore
          .collection(FireStoreName.RootCollectionRooms)
          .getDocuments();

  var test = await firestore.document("/users/${appBloc.profileData['uId']}").get();
      List roomIds = test.data.values.elementAt(0);
  print(test.data.length);
  for(int i=0 ; i< roomIds.length ; i++){
//    zoomId.add(Zoom(zoomId: roomIds[i]));
    var data = await firestore.collection("/${FireStoreName.RootCollectionRooms}/${roomIds[i]}/userofroom").getDocuments();
    var listUserID = data.documents; // user id inside room
    final List<String> zoomTitle = [];
    final List<String> image = [];
    final List<String> documentId = [];
    for(var userID in listUserID){
      if(userID.documentID == appBloc.profileData["uId"]){
        continue;
      }else{
        zoomTitle.add(userID.data["name"]);
        image.add(userID.data["img"]);
        documentId.add(userID.documentID);
      }
    }
    roomId.add(Room(
      roomId: roomIds[i],
      roomTitle: zoomTitle?.join(',') ?? "",
      img: image.isNotEmpty ? image[0] : "",
      documentId: documentId.isNotEmpty?documentId[0]:""
    ));
  }
//      for (int i = 0; i < listRoom.documents.length; i++) {
//        for (int j = 0; j < roomIds.length; j++) {
//          if (roomIds[j] == listRoom.documents[i].documentID) {
//            var data = await firestore
//                .collection(FireStoreName.RootCollectionRooms)
//                .document(listRoom.documents[i].documentID)
//                .collection('userofroom')
//                .getDocuments();
//            documentSnapshot = data.documents;
//          }
//        }
//      }
//      for (int i = 0; i < documentSnapshot.length; i++) {
//        if (appBloc.profileData['uId'] == documentSnapshot[i].documentID) {
//          documentSnapshot.removeAt(i);
//        }
//      }
      yield ChatLoaded();
    }
    if (event is GetMessageEvent) {
      yield RefreshMessageState();
      var chatRoomId = await firestore
          .collection(FireStoreName.RootCollectionUsers)
          .document(appBloc.profileData['uId'])
          .get();
      List roomIds = chatRoomId.data.values.elementAt(0);
      print(roomIds);
      var listRoom = await firestore
          .collection(
              "/rooms/g4NXAAsZBCjERHLoZgdZ/userofroom/7N2W3kc9DZhatFgegQvYuOwWFXs1")
          .getDocuments();
      print(listRoom);

      for (int i = 0; i < listRoom.documents.length; i++) {
        for (int j = 0; j < roomIds.length; j++) {
          if (roomIds[j] == listRoom.documents[i].documentID) {
            var data = firestore
                .collection(FireStoreName.RootCollectionRooms)
                .document(listRoom.documents[i].documentID)
                .collection('userofroom')
                .snapshots();
            documentSnapshot1 = data;
          }
        }
      }
      yield LoadMessageSuccessState();
    }

    if (event is CreateMessageEvent) {
      DateTime time = DateTime.now();
      Firestore.instance.collection(FireStoreName.RootCollectionRooms).document(appBloc.roomId).collection("userofroom").document(appBloc.profileData['uId']).collection('message').add({
        "messContent":event.mess,
        "time":time.toUtc(),
        "userId":appBloc.profileData['uId']
      }).then((value){
       print('ok');
      });

      Firestore.instance.collection(FireStoreName.RootCollectionRooms).document(appBloc.roomId).collection("userofroom").document(appBloc.userIdRoom).collection('message').add({
        "messContent":event.mess,
        "time":time.toUtc(),
        "userId":appBloc.profileData['uId']
      }).then((value){
        print('ok');
      });
//      Firestore.instance
//          .collection(FireStoreName.RootCollectionRooms)
//          .document("g4NXAAsZBCjERHLoZgdZ")
//          .collection("userofroom")
//          .add({
//        "ListMessage": {'message': 'tét', 'userID': appBloc.profileData['uId']}
//      }).then((value) {
//        print('fb');
//      });
    }

    if (event is LoadMoreChat) {
      var res = await chatProvider.getListChat();
      if (res == null) {}
      this.listData = listData + res.data;
      yield ChatLoaded();
    }
  }
}
