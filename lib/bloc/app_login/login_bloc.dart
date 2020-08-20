import 'dart:convert';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_login_google/bloc/app_bloc/app_bloc.dart';
import 'package:fb_login_google/bloc/app_login/login_state.dart';
import 'package:bloc/bloc.dart';
import 'package:fb_login_google/contains/fire_store_name.dart';
import 'package:fb_login_google/contains/save_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  SaveProfile _profile = new SaveProfile();
  final AppBloc appBloc;

  LoginBloc({this.appBloc}) : super(InitalLogin());

  Map profileData;
  FirebaseAuth _auth = FirebaseAuth.instance;
  var _firestore = Firestore.instance;
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  Map<String, String> userProfile = new Map();

  getUserProfile() async {
    profileData = await _profile.getData();
    if (profileData != null) {
      appBloc.profileData = profileData;
      this.add(RedirectHome());
    } else {
      this.add(RedirectLogin());
    }
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginAppEvent) {
      try {
        yield LoadingLoginState();
//        var profile =
//        await googleSignIn.signIn();
//        userProfile =  {
//          "link_url":profile.photoUrl,
//          "name":profile.displayName,
//          "email":profile.email
//        };

        AuthResult result = await _auth.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        yield LoadingLoginState();
        if (result == null) {
          return;
        }

        userProfile = {
          "email": result.user.email,
          "link_url":
              "https://media.loveitopcdn.com/818/tnr-9-hinh-anh-dep-ve-bien.jpg",
          "uId": result.user.uid
        };
        await _profile.setData(jsonEncode(userProfile));
        profileData = await _profile.getData();
        if (profileData == null || profileData.isEmpty) {
          yield LoginErrorState();
          return;
        }

        appBloc.profileData = profileData;
        yield LoginSuccessState();
      } catch (error) {}
    }

    if (event is SignUp) {
      yield LoadingLoginState();
      var userId = await _auth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      if (userId.user.uid != null || userId.user.uid != "") {
        _firestore
            .collection(FireStoreName.RootCollectionUsers)
            .document(userId.user.uid)
            .setData({FireStoreName.ChatRoomIDs:[]}).then((value) {});
      }
      yield LoginSuccessState();
    }

    if (event is LogoutAppEvent) {
      yield LoadingLoginState();
//      await googleSignIn.disconnect();
      await _profile.deleteData();
      yield LogoutSuccessState();
    }

    if (event is RedirectLogin) {
      yield RedirectLoginState();
    }

    if (event is RedirectHome) {
      yield RedirectHomeState();
    }
  }
}
