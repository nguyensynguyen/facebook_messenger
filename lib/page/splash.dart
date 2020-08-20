import 'package:fb_login_google/bloc/app_bloc/app_bloc.dart';
import 'package:fb_login_google/bloc/app_login/login_bloc.dart';
import 'package:fb_login_google/bloc/app_login/login_state.dart';
import 'package:fb_login_google/contains/routers.dart';
import 'package:fb_login_google/contains/save_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Splash();
  }
}

class _Splash extends State<Splash> with TickerProviderStateMixin {
  SaveProfile _pre = new SaveProfile();
  AppBloc _appBloc;
  LoginBloc _LoginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appBloc = BlocProvider.of<AppBloc>(context);
    _LoginBloc = new LoginBloc(appBloc: _appBloc);
    _LoginBloc.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: _LoginBloc,
        listener: (context, state) async {
          if (state is RedirectHomeState) {
            await Future.delayed(const Duration(milliseconds: 1000));
            Navigator.pushReplacementNamed(context, Routers.homePage);
          }
          if (state is RedirectLoginState) {
            await Future.delayed(const Duration(milliseconds: 1000));
            Navigator.pushReplacementNamed(context, Routers.logIn);
          }
        },
        child: Center(child: Image.asset("image/unnamed.gif")),
      ),
    );
  }
}
