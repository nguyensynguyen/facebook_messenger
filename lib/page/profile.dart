import 'package:fb_login_google/bloc/app_bloc/app_bloc.dart';
import 'package:fb_login_google/bloc/app_login/login_bloc.dart';
import 'package:fb_login_google/bloc/app_login/login_event.dart';
import 'package:fb_login_google/bloc/app_login/login_state.dart';
import 'package:fb_login_google/contains/routers.dart';
import 'package:fb_login_google/contains/save_profile.dart';
import 'package:fb_login_google/page/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login/login.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  SaveProfile _pre = new SaveProfile();
  AppBloc _appBloc;
  LoginBloc _LoginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _LoginBloc = new LoginBloc();
    _appBloc = BlocProvider.of<AppBloc>(context);
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
                    "処理中",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
          bloc: _LoginBloc,
          listener: (context, state) {
            if (state is LoadingLoginState) {
              showDialogProgress(context: context);
            }

            if (state is LogoutSuccessState) {
//              Navigator.removeRoute(context, MaterialPageRoute( builder: (BuildContext context) => Profile()));
//              Navigator.removeRoute(context, MaterialPageRoute( builder: (BuildContext context) => HomePage()));
//              Navigator.push(context,  MaterialPageRoute( builder: (BuildContext context) => Login()));
              Navigator.pushReplacementNamed(context, Routers.logOut);
              return;
            }
          },
          child: BlocBuilder(
            bloc: _LoginBloc,
            builder: (context, state) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(0.8, 0.0),
                                  // 10% of the width, so there are ten blinds.
                                  colors: [
                                    const Color(0xFF26A69A),
                                    const Color(0xFF999999),
                                  ],
                                  // whitish to gray
                                  tileMode: TileMode
                                      .repeated, // repeats the gradient over the canvas
                                ),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FlatButton(
                                      child: Text(
                                        "logout",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "RobotoMono"),
                                      ),
                                      color: Colors.white,
                                      onPressed: () {
                                        _LoginBloc.add(LogoutAppEvent());
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: <Widget>[],
                              ),
                              color: Colors.amber,
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.23,
                        left: MediaQuery.of(context).size.width * 0.4,
                        child: Stack(
                          children: <Widget>[
                            CircleAvatar(
                                radius: 40.0,
                                backgroundImage: _appBloc.profileData == null
                                    ? NetworkImage(
                                        'https://gamek.mediacdn.vn/2019/3/31/anh-1-1554010168855935071981.jpg')
                                    : NetworkImage(
                                        _appBloc.profileData['link_url'])),
                            Positioned(
                              top: 56,
                              left: 46,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
//              Container(
//                decoration: BoxDecoration(
//                  gradient: LinearGradient(
//                    begin: Alignment.topLeft,
//                    end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
//                    colors: [const Color(0xFFFFFFEE), const Color(0xFF999999)], // whitish to gray
//                    tileMode: TileMode.repeated, // repeats the gradient over the canvas
//                  ),
//                ),
//                alignment: Alignment.center,
//                width: MediaQuery.of(context).size.width,
//                height: MediaQuery.of(context).size.height*0.2,
//                child: Stack(
//                  children: <Widget>[
//                    CircleAvatar(
//                        radius:
//                        40.0,
//                        backgroundImage:_appBloc.userProfile.isEmpty? NetworkImage('https://gamek.mediacdn.vn/2019/3/31/anh-1-1554010168855935071981.jpg'):NetworkImage(_appBloc.userProfile['link_url'])),
//                    Positioned(
//                      top: 56,
//                      left: 46,
//                      child: Icon(Icons.camera_alt,color: Colors.grey,size: 30,),
//                    )
//                  ],
//                ),
//              ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
