import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm/data/response/api_response.dart';
import 'package:flutter_mvvm/main.dart';
import 'package:flutter_mvvm/repository/product_repository.dart';
import 'package:flutter_mvvm/utils/utils.dart';

import '../model/product_model.dart';

class ProductViewModel with ChangeNotifier {
  final _productRepository = ProductRepository();

  ApiResponse<ProductModel> _apiResponseProductList = ApiResponse.isLoading();

  ApiResponse<ProductModel> get response =>_apiResponseProductList;

  setProductList(ApiResponse<ProductModel> productList) {
    _apiResponseProductList = productList;
    notifyListeners();
  }

  Future<void> fetchProductList() async {
    setProductList(ApiResponse.isLoading());
    _productRepository.getFetchProductList().then((value) async {
       Utils.showFlashBarMessage(
          "Success", FlasType.success, navigatorKey.currentContext!);

      ProductModel productModel =  ProductModel.fromJson(value);
       print("value is : "+ value.toString());
      setProductList(ApiResponse.completed(productModel));

    }).onError((error, stackTrace) {
      Utils.showFlashBarMessage(
          error.toString(), FlasType.error, navigatorKey.currentContext!);
      setProductList(ApiResponse.error(error.toString()));
      print(error);
    });
  }
}
