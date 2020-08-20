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

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUpScreen> {
  AppBloc _appBloc;
  LoginBloc _LoginBloc;
  TextEditingController txt_email = new TextEditingController();
  TextEditingController txt_password = new TextEditingController();

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
            Navigator.pushReplacementNamed(context, Routers.logIn);
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
                    child: Text("Sign Up"),
                    onPressed: () {
                      print(txt_email.text.substring(0,txt_email.text.length));
                      _LoginBloc.add(SignUp(
                          email: txt_email.text.substring(0,txt_email.text.length),
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
                    "Log Out",
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
