import 'package:flutter_mvvm/data/network/base_api_services.dart';
import 'package:flutter_mvvm/data/network/network_api_services.dart';
import 'package:flutter_mvvm/res/urls.dart';

class ProductRepository {
  final BaseApiServices _apiServices = NetworkAPiServices();

  Future<dynamic> getFetchProductList() async {
    try {
    dynamic response = await _apiServices.getApiResponse(Urls.productsEndPoint);
    print("response"+ response.toString());
    return response;
    } catch (error) {
      rethrow;
    }
  }
}
