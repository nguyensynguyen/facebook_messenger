import 'dart:convert';
import 'dart:core';
import 'package:fb_login_google/bloc/app_bloc/app_bloc.dart';
import 'package:fb_login_google/bloc/app_login/login_state.dart';
import 'package:bloc/bloc.dart';
import 'package:fb_login_google/contains/save_profile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  SaveProfile _profile = new SaveProfile();
  final AppBloc appBloc;
  LoginBloc({this.appBloc}) : super(InitalLogin());

  Map profileData;
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  Map<String,String> userProfile = new Map();
 getUserProfile() async{
      profileData =await _profile.getData();
     if(profileData !=null){
      appBloc.profileData = profileData;
      this.add(RedirectHome());
    }
     else{
       this.add(RedirectLogin());
     }
 }
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginAppEvent){
      try {
        yield LoadingLoginState();
        var profile =
        await googleSignIn.signIn();
        userProfile =  {
          "link_url":profile.photoUrl,
          "name":profile.displayName
        };
        await _profile.setData(jsonEncode(userProfile)) ;
        profileData = await _profile.getData();
        if(profileData == null || profileData.isEmpty){
          yield LoginErrorState();
          return;
        }
        appBloc.profileData = profileData;
        yield LoginSuccessState();
      } catch (error) {

      }

    }

    if(event is LogoutAppEvent){
      yield LoadingLoginState();
      await googleSignIn.disconnect();
      await _profile.deleteData();
      yield LogoutSuccessState();

    }

    if(event is RedirectLogin){
      yield RedirectLoginState();
    }

    if(event is RedirectHome){
      yield RedirectHomeState();
    }
  }

}
