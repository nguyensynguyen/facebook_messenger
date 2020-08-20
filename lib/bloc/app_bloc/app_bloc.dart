import 'dart:core';

import 'package:fb_login_google/bloc/app_bloc/app_state.dart';
import 'package:bloc/bloc.dart';
import 'package:fb_login_google/contains/save_profile.dart';
import 'package:fb_login_google/page/home.dart';
import 'package:flutter/material.dart';
import 'app_event.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  SaveProfile _profile = new SaveProfile();
  String userName;
  String roomId;
  String userIdRoom;
  String img;
  Map profileData;
  BuildContext context;
  Map<String, String> userProfile = new Map();

  getData(BuildContext context) async {
    profileData = await _profile.getData();
    if (profileData != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  AppBloc() : super(InitalApp());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is GetProfileUsers) {
      yield GetDataSuccess();
    }
  }
}
