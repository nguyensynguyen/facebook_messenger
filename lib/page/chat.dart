import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_login_google/bloc/app_bloc/app_bloc.dart';
import 'package:fb_login_google/bloc/chat_bloc/chat_bloc.dart';
import 'package:fb_login_google/bloc/chat_bloc/chat_event.dart';
import 'package:fb_login_google/bloc/chat_bloc/chat_state.dart';
import 'package:fb_login_google/contains/fire_store_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class MessChat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MessChat();
  }
}

class _MessChat extends State<MessChat> {
  final ScrollController _controller1 = ScrollController();
  List mess = [];
  AppBloc _appBloc;
  TextEditingController _controller = TextEditingController();
  bool isKeyboardShow = false;
  bool isSend = false;
  int maxLines = 1;
  double fontSize = 10.0;
  DocumentSnapshot _documentSnapshot;
  ChatBloc _chatBloc;
  DateFormat _dateFormat = DateFormat("dd/MM/yyyy HH:mm a");
  final KeyboardVisibilityNotification _notification =
      KeyboardVisibilityNotification();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appBloc = BlocProvider.of<AppBloc>(context);
    _chatBloc = new ChatBloc(appBloc: _appBloc);
//    _chatBloc.add(GetMessageEvent());
    _notification.addNewListener(
      onChange: (bool visible) {
        setState(() {
          isKeyboardShow = visible;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mess"),
      ),
      body: BlocListener(
          listener: (context, state) {
            if (state is RefreshMessageState) {
              showDialogProgress(context: context);
            }
          },
          bloc: _chatBloc,
          child: BlocBuilder(
            bloc: _chatBloc,
            builder: (context, state) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: StreamBuilder(
                            stream: Firestore.instance
                                .collection(FireStoreName.RootCollectionRooms)
                                .document(_appBloc.roomId)
                                .collection("userofroom")
                                .document(_appBloc.profileData['uId'])
                                .collection('message')
                                .orderBy('time', descending: false)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("loading .... ");
                              }
                              QuerySnapshot querySnapshot = snapshot.data;
                              Future.delayed(const Duration(milliseconds: 200),
                                  () {
                                _controller1.animateTo(
                                    _controller1.position.maxScrollExtent,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOutCirc);
                              });
                              return ListView.builder(
                                  controller: _controller1,
                                  itemCount: querySnapshot.documents.length,
                                  itemBuilder: (context, int index) {
                                    if (querySnapshot.documents[index]
                                            ['userId'] ==
                                        _appBloc.profileData['uId']) {
                                      return Align(
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                          ),
                                          child: Container(
                                              margin: const EdgeInsets.all(12),
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                  querySnapshot.documents[index]
                                                      ['messContent'],
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white))),
                                        ),
                                        alignment: Alignment.centerRight,
                                      );
                                    } else {
                                      return Align(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            children: <Widget>[
                                              CircleAvatar(
                                                backgroundImage:
                                                    NetworkImage(_appBloc.img),
                                              ),
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.8,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              bottom: 4),
                                                      child: Text(
                                                        "${_appBloc.userName}\t${querySnapshot.documents[index]['time'] != null ? _formatDateTime(DateTime.fromMillisecondsSinceEpoch((querySnapshot.documents[index]['time'] is int ? querySnapshot.documents[index]['time'] * 1000 : querySnapshot.documents[index]['time'].seconds * 1000 ))) : ""}",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 8),
                                                        padding:
                                                            EdgeInsets.all(6),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[400],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Text(
                                                            querySnapshot
                                                                        .documents[
                                                                    index]
                                                                ['messContent'],
                                                            style: const TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .white)))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                      );
                                    }
                                  });

////                          SingleChildScrollView(
////                            child: Column(
////                          mainAxisSize: MainAxisSize.min,
////                          children: <Widget>[
////                            Text(snapshot.data[0]['name'])
////                          ],
//////                                children: <Widget>[
//////                                  Align(
//////                                    child: Container(
//////                                        margin: const EdgeInsets.all(12),
//////                                        padding: const EdgeInsets.all(8),
//////                                        decoration: BoxDecoration(
//////                                          color: Colors.blue,
//////                                          borderRadius: BorderRadius.circular(20),
//////                                        ),
//////                                        child:Text('fsdgsgegw', style: const TextStyle(
//////                                            fontSize: 20, color: Colors.white))
//////                                    ),
//////                                    alignment: Alignment.centerRight,
//////                                  ),
//////                                  Align(
//////                                    child: Container(
//////                                        margin: const EdgeInsets.all(12),
//////                                        padding: const EdgeInsets.all(8),
//////                                        decoration: BoxDecoration(
//////                                          color: Colors.grey,
//////                                          borderRadius: BorderRadius.circular(20),
//////                                        ),
//////                                        child:Text('f', style: const TextStyle(
//////                                            fontSize: 20, color: Colors.white))
//////                                    ),
//////                                    alignment: Alignment.centerLeft,
//////                                  )
//////                                ],
////                        ));
//                      },
//                    )
                            })),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 400),
                              transitionBuilder: (widget, animation) {
                                return SizeTransition(
                                  sizeFactor: animation,
                                  child: widget,
                                );
                              },
                              child: !isKeyboardShow
                                  ? Row(
                                      children: <Widget>[
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Icon(
                                          Icons.featured_video,
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Icon(
                                          Icons.linked_camera,
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Icon(
                                          Icons.image,
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Icon(
                                          Icons.mic,
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                      ],
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isKeyboardShow = false;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.blue,
                                      ),
                                    ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextField(
                                  onChanged: (value) {
                                    if (value.isNotEmpty && !isSend) {
                                      setState(() {
                                        isSend = true;
                                        isKeyboardShow = true;
                                      });
                                      return;
                                    }
                                    if (value.isEmpty) {
                                      setState(() {
                                        isSend = false;
                                      });
                                    }
                                  },
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Aa',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            !isSend
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.redAccent,
                                  )
                                : IconButton(
                                    onPressed: () {
                                      _chatBloc.add(CreateMessageEvent(
                                          mess: _controller.text));
                                      _controller.clear();
                                      setState(() {
                                        isSend = false;
                                      });
                                    },
                                    icon: Icon(Icons.send),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }

  void showDialogProgress({@required context}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Load...",
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDateTime(final DateTime dateTime) {
    return _dateFormat.format(dateTime);
  }

//  _buildItem(dynamic item){
//    List<Widget> allText =[];
//    for(var x in item){
//      allText.add(Text(x.toString()));
//    }
//print(allText);
//    return Column(
//       children:allText);
//  }
  @override
  void dispose() {
    _notification.dispose();
    super.dispose();
  }
}
