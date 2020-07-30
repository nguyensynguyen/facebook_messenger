import 'package:fb_login_google/bloc/chat/chat_bloc.dart';
import 'package:fb_login_google/bloc/chat/chat_event.dart';
import 'package:fb_login_google/bloc/chat/chat_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'news_detail.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: close_sinks
  ChatBloc _chatBloc = new ChatBloc();
  int lenght = 0;
  ScrollController _scrollController;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignIn _signIn = new GoogleSignIn();
  String _contactText;

  @override
  void initState() {
    super.initState();
    _chatBloc.add(LoadChat());
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll == currentScroll) {
        _chatBloc.add(LoadMoreChat());
      }
    });
  }

  @override
  bool isSend = true;
  bool newMess = true;
  bool iSeen = true;
  bool isOnline = true;
  String str = 'Chats';
  bool checkMess = true;
  bool checkContact = false;
  bool checkTab = true;
  var user;
  String img =
      'https://baoquocte.vn/stores/news_dataimages/tranlieu/092016/19/10/103518_anh_1.jpg';
  bool isSignIn = false;

  _UIContact1() {
    return checkTab
        ? BlocBuilder(
            bloc: _chatBloc,
            builder: (BuildContext context, ChatState sate) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              checkTab = true;
                            });
                          },
                          child: checkTab
                              ? Container(
                                  alignment: Alignment.center,
                                  width: 130.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(23.0))),
                                  child: Text(
                                    'TIN(22)',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  width: 130.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(23.0))),
                                  child: Text(
                                    'TIN(22)',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                checkTab = false;
                                print(checkTab);
                              });
                            },
                            child: checkTab
                                ? Container(
                                    alignment: Alignment.center,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(23.0))),
                                    child: Text(
                                      'ĐANG HOẠT ĐỘNG(22)',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(23.0))),
                                    child: Text(
                                      'ĐANG HOẠT ĐỘNG(22)',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: BlocBuilder(
                    bloc: _chatBloc,
                    builder: (BuildContext context, ChatState state) {
                      if (state is ChatLoading) {
                        return CupertinoActivityIndicator();
                      }
                      if (state is ChatLoaded) {}
                      return CustomScrollView(slivers: <Widget>[
                        SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  childAspectRatio: 0.89),
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, top: 0.0, right: 8.0),
                                child: index == 0
                                    ? new Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://upload.wikimedia.org/wikipedia/vi/thumb/0/09/MOS_1280_kalel.jpg/300px-MOS_1280_kalel.jpg'),
                                                fit: BoxFit.fill),
                                            color: Colors.green,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0)),
                                            border: Border.all(
                                                color: Colors.lightBlue)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                      // alignment: Alignment.topCenter,
                                                      width: 55.0,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  width: 40.0,
                                                                  height: 40.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    size: 30,
                                                                  ),
                                                                )
                                                              ]),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Text(
                                                  'Thêm vào tin',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ))
                                          ],
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: _chatBloc.listData[index]
                                                            .story ==
                                                        ""
                                                    ? NetworkImage(
                                                        'https://techkalzen.com/wp-content/uploads/2020/01/kimetsu-no-yaiba-artist-kimetsu-takuan.jpg')
                                                    : NetworkImage(_chatBloc
                                                        .listData[index].story),
                                                fit: BoxFit.fill),
                                            color: Colors.green,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0)),
                                            border: Border.all(
                                                color: Colors.lightBlue)),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetail(
                                                        img: _chatBloc
                                                                    .listData[
                                                                        index +
                                                                            1]
                                                                    .story ==
                                                                ""
                                                            ? 'https://techkalzen.com/wp-content/uploads/2020/01/kimetsu-no-yaiba-artist-kimetsu-takuan.jpg'
                                                            : _chatBloc
                                                                .listData[
                                                                    index + 1]
                                                                .story,
                                                      )),
                                            );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                        // alignment: Alignment.topCenter,
                                                        width: 55.0,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    height:
                                                                        54.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.3),
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .blue,
                                                                          width:
                                                                              3.0),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                  ),
                                                                  CircleAvatar(
                                                                      radius:
                                                                          22.0,
                                                                      backgroundImage: NetworkImage(_chatBloc
                                                                          .listData[
                                                                              index]
                                                                          .userAvatar)),
                                                                  Positioned(
                                                                    top: 39,
                                                                    left: 38,
                                                                    child:
                                                                        Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      children: <
                                                                          Widget>[
                                                                        Container(
                                                                          width:
                                                                              15.0,
                                                                          height:
                                                                              15.0,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: new BorderRadius.circular(25.0),
                                                                              border: Border.all(color: Colors.white, width: 2.0),
                                                                              color: Colors.grey[300]),
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              12.0,
                                                                          width:
                                                                              12.0,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: new BorderRadius.circular(25.0),
                                                                              color: Colors.green),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ],
                                                        )),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 16.0,
                                                      width: 16.0,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  25.0),
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.3)),
                                                      child: Text(
                                                        '2',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Text(
                                                    _chatBloc.listData[index]
                                                        .userName,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))
                                            ],
                                          ),
                                        )));
                          }, childCount: _chatBloc.listData.length),
                        )
                      ]);
                    },
                  ))
                ],
              );
            },
          )
        : BlocBuilder(
            bloc: _chatBloc,
            builder: (BuildContext context, ChatState state) {
              return ListView.builder(
                  controller: _scrollController,
                  itemCount: _chatBloc.listData.length,
                  itemBuilder: (context, int index) {
                    return index != 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: _chatBloc.listData[index].isOnline
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        newMess = false;
                                      });
                                    },
                                    child: Container(
                                        height: 54.0,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: double.infinity,
                                                child: Stack(children: <Widget>[
                                                  Container(
                                                    width: 40.0,
                                                    height: 40.0,
                                                  ),
                                                  Positioned(
                                                    child: Stack(
                                                      overflow:
                                                          Overflow.visible,
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                            radius: 19,
                                                            backgroundImage:
                                                                NetworkImage(
                                                              _chatBloc
                                                                  .listData[
                                                                      index]
                                                                  .userAvatar,
                                                            )),
                                                        Positioned(
                                                          top: 24,
                                                          left: 28,
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: <Widget>[
                                                              Container(
                                                                width: 15.0,
                                                                height: 15.0,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        new BorderRadius.circular(
                                                                            25.0),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            2.0),
                                                                    color: Colors
                                                                            .grey[
                                                                        300]),
                                                              ),
                                                              Container(
                                                                height: 12.0,
                                                                width: 12.0,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        new BorderRadius.circular(
                                                                            25.0),
                                                                    color: Colors
                                                                        .green),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          _chatBloc
                                                              .listData[index]
                                                              .userName,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                      ),
//                                                  index == 1
//                                                      ? Padding(
//                                                          padding:
//                                                              const EdgeInsets
//                                                                      .only(
//                                                                  bottom: 3.0,
//                                                                  left: 8.0),
//                                                          child: Text(
//                                                            'User $index đang hoạt động',
//                                                            style: TextStyle(
//                                                                fontWeight:
//                                                                    FontWeight
//                                                                        .w300,
//                                                                fontSize: 12),
//                                                          ),
//                                                        )
//                                                      : Text(
//                                                          '',
//                                                          style: TextStyle(
//                                                              fontSize: 15),
//                                                        )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0, top: 8.0),
                                                child: Container(
                                                    width: 38.0,
                                                    height: 38.0,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        shape: BoxShape.circle),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  'https://cdn1.iconfinder.com/data/icons/hand-gestures-line-art/128/hand-wave-ol-512.png',
                                                                  scale: 20))),
                                                    ))),
                                          ],
                                        )),
                                  )
                                : null)
                        : Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0,
                                left: 16.0,
                                right: 16.0,
                                bottom: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      checkTab = true;
//                    print(checkTab);
                                    });
                                  },
                                  child: checkTab
                                      ? Container(
                                          alignment: Alignment.center,
                                          width: 130.0,
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(23.0))),
                                          child: Text(
                                            'TIN(22)',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          width: 130.0,
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(23.0))),
                                          child: Text(
                                            'TIN(22)',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        checkTab = false;
                                        print(checkTab);
                                      });
                                    },
                                    child: checkTab
                                        ? Container(
                                            alignment: Alignment.center,
                                            height: 30.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(23.0))),
                                            child: Text(
                                              'ĐANG HOẠT ĐỘNG(22)',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            height: 30.0,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(23.0))),
                                            child: Text(
                                              'ĐANG HOẠT ĐỘNG(22)',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          );
                  });
            },
          );
  }

  _UiMess() {
    return SafeArea(
        child: CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.search),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Tìm kiếm'),
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Container(
                height: 85.0,
                child: BlocBuilder(
                  bloc: _chatBloc,
                  builder: (BuildContext context, ChatState state) {
                    if (state is InitalChat) {
                      return Container(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _chatBloc.listData.length,
                        itemBuilder: (context, int index) {
                          return index == 0
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 6.0),
                                  child: Container(
                                    width: 74.0,
                                    height: double.infinity,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: 50.0,
                                          height: 56.0,
                                          child: Icon(Icons.add),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              shape: BoxShape.circle),
                                        ),
                                        Text(
                                          'Tin của bạn',
                                          style: TextStyle(fontSize: 13.0),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : _chatBloc.listData[index].isOnline
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: _chatBloc.listData[index].isNews ==
                                              true
                                          ? Container(

                                              // alignment: Alignment.topCenter,
                                              width: 55.0,
                                              child: Column(
                                                children: <Widget>[
                                                  Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: <Widget>[
                                                        Container(
                                                          height: 54.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color:
                                                                    Colors.blue,
                                                                width: 3.0),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        CircleAvatar(
                                                            radius: 22.0,
                                                            backgroundImage:
                                                                NetworkImage(
                                                              _chatBloc
                                                                  .listData[
                                                                      index]
                                                                  .userAvatar,
                                                            )),
                                                        Positioned(
                                                          top: 39,
                                                          left: 38,
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: <Widget>[
                                                              Container(
                                                                width: 15.0,
                                                                height: 15.0,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        new BorderRadius.circular(
                                                                            25.0),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            2.0),
                                                                    color: Colors
                                                                            .grey[
                                                                        300]),
                                                              ),
                                                              Container(
                                                                height: 12.0,
                                                                width: 12.0,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        new BorderRadius.circular(
                                                                            25.0),
                                                                    color: Colors
                                                                        .green),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ]),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3.0),
                                                    child: Text(_chatBloc
                                                        .listData[index]
                                                        .userName),
                                                  )
                                                ],
                                              ))
                                          : Container(

                                              // alignment: Alignment.topCenter,
                                              width: 50.0,
                                              child: Column(
                                                children: <Widget>[
                                                  Stack(
                                                      //   alignment: Alignment.bottomRight,
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                            radius: 26.0,
                                                            backgroundImage:
                                                                NetworkImage(
                                                              _chatBloc
                                                                  .listData[
                                                                      index]
                                                                  .userAvatar,
                                                            )),
                                                        Positioned(
                                                          top: 38,
                                                          left: 36,
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: <Widget>[
                                                              Container(
                                                                width: 15.0,
                                                                height: 15.0,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        new BorderRadius.circular(
                                                                            25.0),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            2.0),
                                                                    color: Colors
                                                                            .grey[
                                                                        300]),
                                                              ),
                                                              Container(
                                                                height: 12.0,
                                                                width: 12.0,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        new BorderRadius.circular(
                                                                            25.0),
                                                                    color: Colors
                                                                        .green),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ]),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3.0),
                                                    child: Text(_chatBloc
                                                        .listData[index]
                                                        .userName),
                                                  )
                                                ],
                                              )),
                                    )
                                  : Container();
                        });
                  },
                )),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 70.0,
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return InkWell(
              onTap: () {
                setState(() {
                  newMess = false;
                });
              },
              child: Container(
                  height: 102.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Stack(alignment: Alignment.center, children: <
                              Widget>[
                            Container(
                              width: 66.0,
                              height: 70,
                            ),
                            Positioned(
                              child: Stack(
                                overflow: Overflow.visible,
                                alignment: Alignment.bottomRight,
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: 26,
                                      backgroundImage: NetworkImage(
                                        'https://upload.wikimedia.org/wikipedia/vi/thumb/0/09/MOS_1280_kalel.jpg/300px-MOS_1280_kalel.jpg',
                                      )),
                                  index == 3
                                      ? Positioned(
                                          left: 30.0,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 40.0,
                                                height: 15.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(25.0),
                                                    color: Colors.grey[300]),
                                              ),
                                              Container(
                                                height: 12.0,
                                                width: 35.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(25.0),
                                                    color: Colors.green),
                                                child: Text(
                                                  ' 3 phút',
                                                  style: TextStyle(
                                                      fontSize: 10.0,
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ))
                                      : Positioned(
                                          child: Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 15.0,
                                              height: 15.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          25.0),
                                                  color: Colors.grey[300]),
                                            ),
                                            Container(
                                              height: 12.0,
                                              width: 12.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          25.0),
                                                  color: Colors.green),
                                            )
                                          ],
                                        ))
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3.0),
                                  child: Text(
                                    'User $index',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                index == 1
                                    ? Text(
                                        'If youve ever wanted ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    : index == 2
                                        ? Text(
                                            'seen',
                                            style: TextStyle(fontSize: 15),
                                          )
                                        : Text('no mess')
                              ],
                            ),
                          ),
                        ),
                      ),
                      index == 1
                          ? Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Container(
                                height: 13.0,
                                width: 13.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    color: Colors.blue),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: index == 2
                                  ? CircleAvatar(
                                      radius: 7,
                                      backgroundImage: NetworkImage(
                                        'https://3.bp.blogspot.com/-2Nj1cR7p8KE/WZUuy1hZpLI/AAAAAAAATWk/woFZ8V3GldoCNKLSXXLkz0FNfazRWRdCACLcBGAs/s1600/Taianhdep.club__tai-hinh-anh-de-thuong-kute-de-thuong%2B%252812%2529.jpg',
                                      ))
                                  : Icon(
                                      Icons.check_circle,
                                      color: Colors.grey[400],
                                      size: 16.0,
                                    ),
                            ),
                    ],
                  )),
            );
          }, childCount: 50),
        ),
      ],
    ));
  }

  _UiMess1() {
    return SafeArea(
        child: BlocBuilder(
      bloc: _chatBloc,
      builder: (BuildContext context, ChatState state) {
        if (state is ChatLoading) {
          return Container(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is ChatLoaded) {
          this.lenght = _chatBloc.listData.length + 1;
        }
        return SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
                child: Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.search),
                      ),
                      Expanded(
                        child: Container(
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'Tìm kiếm'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 6.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.14,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 50.0,
                              height: 56.0,
                              child: Icon(Icons.add),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.circle),
                            ),
                            const Text(
                              'Tin của bạn',
                              style: TextStyle(fontSize: 13.0),
                            )
                          ],
                        ),
                      ),
                    )
                  ]..addAll(
                      _chatBloc.listData?.map<Widget>((item) {
                        return item.isOnline
                            ? Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: item.isNewStory == true
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NewsDetail(
                                                      img: item.story,
                                                      userAvatar:
                                                          item.userAvatar,
                                                    )),
                                          );
                                        },
                                        child: Container(
                                            // alignment: Alignment.topCenter,
                                            width: 55.0,
                                            child: Column(
                                              children: <Widget>[
                                                Stack(
                                                    alignment: Alignment.center,
                                                    children: <Widget>[
                                                      Container(
                                                        height: 54.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.blue,
                                                              width: 3.0),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      CircleAvatar(
                                                          radius: 22.0,
                                                          backgroundImage:
                                                              NetworkImage(
                                                            item.userAvatar,
                                                          )),
                                                      Positioned(
                                                        top: 39,
                                                        left: 38,
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: <Widget>[
                                                            Container(
                                                              width: 15.0,
                                                              height: 15.0,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                              .circular(
                                                                          25.0),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .white,
                                                                      width:
                                                                          2.0),
                                                                  color: Colors
                                                                          .grey[
                                                                      300]),
                                                            ),
                                                            Container(
                                                              height: 12.0,
                                                              width: 12.0,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                              .circular(
                                                                          25.0),
                                                                  color: Colors
                                                                      .green),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ]),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3.0),
                                                  child: Text(item.userName),
                                                )
                                              ],
                                            )),
                                      )
                                    : Container(
                                        // alignment: Alignment.topCenter,
                                        width: 50.0,
                                        child: Column(
                                          children: <Widget>[
                                            Stack(
                                                //   alignment: Alignment.bottomRight,
                                                children: <Widget>[
                                                  CircleAvatar(
                                                      radius: 26.0,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        item.userAvatar,
                                                      )),
                                                  Positioned(
                                                    top: 38,
                                                    left: 36,
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: <Widget>[
                                                        Container(
                                                          width: 15.0,
                                                          height: 15.0,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  new BorderRadius
                                                                          .circular(
                                                                      25.0),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2.0),
                                                              color: Colors
                                                                  .grey[300]),
                                                        ),
                                                        Container(
                                                          height: 12.0,
                                                          width: 12.0,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  new BorderRadius
                                                                          .circular(
                                                                      25.0),
                                                              color:
                                                                  Colors.green),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3.0),
                                              child: Text(item.userName),
                                            )
                                          ],
                                        )),
                              )
                            : Container();
                      })?.toList(),
                    ),
                ),
              ),
              Column(
                children: _chatBloc.listData?.map<Widget>((item) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        newMess = false;
                      });
                    },
                    child: Container(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: 80.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child:
                                Stack(alignment: Alignment.center, children: <
                                    Widget>[
                              Container(
                                width: 66.0,
                                height: 70,
                              ),
                              Positioned(
                                child: Stack(
                                  overflow: Overflow.visible,
                                  alignment: Alignment.bottomRight,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 26,
                                      backgroundImage: NetworkImage(
                                        item.userAvatar,
                                      ),
                                    ),
                                    item.isOnline == false
                                        ? Positioned(
                                            left: 30.0,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: <Widget>[
                                                Container(
                                                  width: 40.0,
                                                  height: 15.0,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(25.0),
                                                      color: Colors.grey[300]),
                                                ),
                                                Container(
                                                  height: 12.0,
                                                  width: 35.0,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(25.0),
                                                      color: Colors.green),
                                                  child: Text(
                                                    ' 3 phút',
                                                    style: TextStyle(
                                                        fontSize: 10.0,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ))
                                        : Positioned(
                                            child: Stack(
                                            alignment: Alignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 15.0,
                                                height: 15.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(25.0),
                                                    color: Colors.grey[300]),
                                              ),
                                              Container(
                                                height: 12.0,
                                                width: 12.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(25.0),
                                                    color: Colors.green),
                                              )
                                            ],
                                          ))
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3.0),
                                    child: Text(
                                      item.userName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  item.isNews
                                      ? Text(
                                          item.messenger,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )
                                      : item.isSeen == false
                                          ? Text(
                                              item.messenger,
                                              style: TextStyle(fontSize: 15),
                                            )
                                          : Text(item.messenger)
                                ],
                              ),
                            ),
                          ),
                        ),
                        item.isNews
                            ? Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Container(
                                  height: 13.0,
                                  width: 13.0,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                      color: Colors.blue),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: item.isSeen == false
                                    ? CircleAvatar(
                                        radius: 7,
                                        backgroundImage: NetworkImage(
                                          'https://3.bp.blogspot.com/-2Nj1cR7p8KE/WZUuy1hZpLI/AAAAAAAATWk/woFZ8V3GldoCNKLSXXLkz0FNfazRWRdCACLcBGAs/s1600/Taianhdep.club__tai-hinh-anh-de-thuong-kute-de-thuong%2B%252812%2529.jpg',
                                        ))
                                    : Icon(
                                        Icons.check_circle,
                                        color: Colors.grey[400],
                                        size: 16.0,
                                      ),
                              ),
                      ],
                    )),
                  );
                })?.toList()
                  ..add(CupertinoActivityIndicator()),
              )
            ],
          ),
        );
      },
    ));
  }

  Widget build(BuildContext context) {
    PageController _myPage = PageController(initialPage: 0);
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: InkWell(
                      onTap: () {
                        _myPage.jumpToPage(0);
                        setState(() {
                          checkMess = true;
                          str = 'Chats';
                          this.checkContact = false;
                        });
                      },
                      child: Container(
                        width: 100.0,
                        child: Column(
                          children: <Widget>[
                            Stack(
                              overflow: Overflow.visible,
                              children: <Widget>[
                                checkMess
                                    ? Icon(
                                        Icons.message,
                                        size: 30.0,
                                        color: Colors.black,
                                      )
                                    : Icon(
                                        Icons.message,
                                        color: Colors.grey[400],
                                        size: 30.0,
                                      ),
                                Positioned(
                                    left: 20.0,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          width: 17.0,
                                          height: 17.0,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2.0)),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 14.0,
                                          height: 14.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.deepOrange,
                                          ),
                                          child: Text(
                                            '8',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0),
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text('Chat'),
                            )
                          ],
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: InkWell(
                      onTap: () {
                        _myPage.jumpToPage(1);
                        setState(() {
                          str = 'Danh ba';
                          this.checkContact = true;
                          this.checkMess = false;
                        });
                      },
                      child: Container(
                        width: 100.0,
                        child: Column(
                          children: <Widget>[
                            Stack(
                              overflow: Overflow.visible,
                              children: <Widget>[
                                checkContact
                                    ? Icon(
                                        Icons.account_box,
                                        size: 30.0,
                                        color: Colors.black,
                                      )
                                    : Icon(
                                        Icons.account_box,
                                        color: Colors.grey[400],
                                        size: 30.0,
                                      ),
                                Positioned(
                                    left: 20.0,
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          width: 20.0,
                                          height: 17.0,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 20.0,
                                          height: 14.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                          ),
                                          child: Text(
                                            '81',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0),
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Danh ba',
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 5.0,
          flexibleSpace: Container(
            height: 25.0,
            width: 25.0,
            color: Colors.green,
          ),
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  image: DecorationImage(
                      image: NetworkImage(
                         user['link_url'] == ''?
                          'https://gamek.mediacdn.vn/2019/3/31/anh-1-1554010168855935071981.jpg': user['link_url'],
                          scale: 6.0),
                      fit: BoxFit.fill)),
            ),
          ),
          title: Text(
            this.str,
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[200], shape: BoxShape.circle),
                  child: InkWell(
                    onTap: () {
                      _setUpGoogleSignIn();
                    },
                    child: Container(
                        child: Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                      size: 16.0,
                    )),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[200], shape: BoxShape.circle),
                  child: Container(
                      child: Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: 16.0,
                  ))),
            ),
          ],
        ),
        body: PageView(
          controller: _myPage,
          children: <Widget>[_UiMess1(), _UIContact1()],
        ));
  }

//  Future<void> handleSigin() async {
//    GoogleSignInAccount googleSignInAccount = await _signIn.signIn();
//    GoogleSignInAuthentication googleSignInAuthentication =
//        await googleSignInAccount.authentication;
//    AuthCredential authCredential = GoogleAuthProvider.getCredential(
//        idToken: googleSignInAuthentication.idToken,
//        accessToken: googleSignInAuthentication.accessToken);
//    AuthResult authResult = (await _auth.signInWithCredential(authCredential));
//    _user = authResult.user;
//    user.add(_user);
//    setState(() {
//      isSignIn = true;
//    });
//  }
   _setUpGoogleSignIn() async { try {
   var profile =
    await _googleSignIn.signIn();
   user = {
     "link_url":profile.photoUrl,
     "name":profile.displayName
   };
  } catch (error) {
    print(error);
  }
  }
}
