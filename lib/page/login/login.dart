import 'package:fb_login_google/bloc/app_bloc/app_bloc.dart';
import 'package:fb_login_google/bloc/app_login/login_bloc.dart';
import 'package:fb_login_google/bloc/app_login/login_event.dart';
import 'package:fb_login_google/bloc/app_login/login_state.dart';
import 'package:fb_login_google/contains/routers.dart';
import 'package:fb_login_google/page/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  AppBloc _appBloc;
  LoginBloc _LoginBloc;
  TextEditingController txt_email = TextEditingController();
  TextEditingController txt_password = TextEditingController();

  @override
  void initState() {
    super.initState();

    _appBloc = BlocProvider.of<AppBloc>(context);
    _LoginBloc = new LoginBloc(appBloc: _appBloc);
    _LoginBloc.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        listener: (context, currentState) {
          if (currentState is LoadingLoginState) {
            showDialogProgress(context: context);
          }
          if (currentState is LoginSuccessState) {
            Navigator.pushNamedAndRemoveUntil(context, Routers.homePage, (Route<dynamic> route) => false);
            return;
          }
        },
        bloc: _LoginBloc,
        child: BlocBuilder(
          bloc: _LoginBloc,
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      _LoginBloc.add(LoginAppEvent());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Text(
                        "login With Google",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routers.SigUp);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  TextField(
                    controller: txt_email,
                    decoration: InputDecoration(hintText: "email"),
                  ),
                  TextField(
                    controller: txt_password,
                    decoration: InputDecoration(hintText: "password"),
                  ),
                  FlatButton(
                    color: Colors.blue,
                    child: Text("Sign In"),
                    onPressed: () {
                      print(txt_email.text.substring(0, txt_email.text.length));
                      _LoginBloc.add(LoginAppEvent(
                          email: txt_email.text
                              .substring(0, txt_email.text.length),
                          password: txt_password.text));
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
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
}
