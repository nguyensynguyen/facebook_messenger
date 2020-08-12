import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SaveProfile {
  Future<dynamic> setData(dynamic data ) async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    if(data == null){
      print("data null");
      return null;
    }else{
      _preferences.setString("profile", data);
    }
    return  _preferences.setString("profile", data);
  }

 Future<dynamic> getData () async{
   SharedPreferences _preferences = await SharedPreferences.getInstance();
     var profile = _preferences.getString("profile");
     if(profile == null){
       return null;
     }
     return jsonDecode(profile) ;
  }

  Future<dynamic> deleteData()async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("profile");
  }
}