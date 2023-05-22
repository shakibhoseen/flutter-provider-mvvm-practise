

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model/user_model.dart';
import 'package:flutter_mvvm/repository/auth_repository.dart';
import 'package:flutter_mvvm/utils/route/routes_name.dart';
import 'package:flutter_mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier{
  final authRepo = AuthRepository();
  bool _isLoading = false;

  bool get loading=>_isLoading;

  void setLoading(bool isLoading){
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<dynamic>logInApi(dynamic data, BuildContext context) async{
     setLoading(true);
     authRepo.logInApi(data).then((value) {
       //saveToken to userViewModel
       final userViewModel = Provider.of<UserViewModel>(context, listen: false);
       userViewModel.saveUser(UserModel.fromJson(value));
       //
       setLoading(false);
       //Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
      Utils.showFlashBarMessage(value.toString(), FlasType.success, context);



    }).onError((error, stackTrace) {
       setLoading(false);
       Utils.showFlashBarMessage(error.toString(), FlasType.error, context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

}