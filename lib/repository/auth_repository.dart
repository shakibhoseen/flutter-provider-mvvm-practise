import 'package:flutter_mvvm/data/app_exceptions.dart';
import 'package:flutter_mvvm/data/network/base_api_services.dart';
import 'package:flutter_mvvm/data/network/network_api_services.dart';
import 'package:flutter_mvvm/utils/utils.dart';

import '../res/urls.dart';

class AuthRepository{
  final BaseApiServices _apiServices = NetworkAPiServices();

  Future<dynamic> logInApi(dynamic data) async{
    try{
      dynamic response = _apiServices.postAPiResponse(Urls.logInEndPoint, data);
          return response;
    }catch(e){
      rethrow;
    }
  }
}