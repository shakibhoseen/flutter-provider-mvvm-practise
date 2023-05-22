
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm/utils/route/routes_name.dart';
import 'package:flutter_mvvm/utils/utils.dart';
import 'package:flutter_mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class SplashServices with ChangeNotifier{


  void checkAuthentication() async{
    final userViewModel = Provider.of<UserViewModel>(navigatorKey.currentContext! , listen: false);
    userViewModel.getUserToken().then((value) async {
      if(value=="null" || value==null || value.isEmpty){

        Utils.showFlashBarMessage("Token not saved", FlasType.error, navigatorKey.currentContext!);
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(navigatorKey.currentContext!, RoutesName.loginScreen);
      }else{

        Utils.showFlashBarMessage("Token Saved already", FlasType.success, navigatorKey.currentContext!);
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(navigatorKey.currentContext!, RoutesName.homeScreen);
      }
    });
  }


}