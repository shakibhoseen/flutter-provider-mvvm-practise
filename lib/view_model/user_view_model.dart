import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm/model/user_model.dart';
import 'package:flutter_mvvm/res/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier{


  Future<bool> saveUser(UserModel userModel) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(Constant().token, userModel.token.toString());
    return true;
  }

  Future<String?> getUserToken()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(Constant().token);
  }

  Future<bool> removeUserToken()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
     sp.remove(Constant().token);
    return true;
  }

}