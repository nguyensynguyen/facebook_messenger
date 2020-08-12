import 'package:fb_login_google/bloc/app_bloc/app_bloc.dart';
import 'package:fb_login_google/contains/routers.dart';
import 'package:fb_login_google/page/home.dart';
import 'package:fb_login_google/page/login/login.dart';
import 'package:fb_login_google/page/profile.dart';
import 'package:fb_login_google/page/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_bloc/app_event.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Splash(),
        routes: {
          Routers.homePage: (BuildContext context) => HomePage(),
          Routers.logIn: (BuildContext context) => Login(),
          Routers.logOut: (BuildContext context) => Login(),
          Routers.profile: (BuildContext context) => Profile(),
        },
      ),
    );
  }
}
