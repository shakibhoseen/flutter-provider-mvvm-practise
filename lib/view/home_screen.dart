import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/response/api_response.dart';
import 'package:flutter_mvvm/data/response/status.dart';
import 'package:flutter_mvvm/model/product_model.dart';
import 'package:flutter_mvvm/utils/route/routes_name.dart';
import 'package:flutter_mvvm/utils/utils.dart';
import 'package:flutter_mvvm/view_model/product_view_model.dart';
import 'package:flutter_mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //ProductViewModel viewModel = ProductViewModel();
    //viewModel.fetchProductList();

  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final productViewModel = Provider.of<ProductViewModel>(context, listen: false);
    productViewModel.fetchProductList();

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              switch(value){
                case "logout":
                   userViewModel.removeUserToken().then((value){
                     //Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
                     Utils.showFlashBarMessage("Log out successfully", FlasType.success, context);

                   });

              }
            },
            itemBuilder: (context) => [
            const PopupMenuItem(value: "logout",child: Text("Log out"),),
          ],)
        ],
      ),
      body: Consumer<ProductViewModel>(builder: (context, value, child) {
        print("new call $value");
         ApiResponse<ProductModel> actualValue = value.response;
         List<Products>? productModelList = actualValue.data?.products;
         return buildProductModelList(actualValue.status ?? Status.error  , actualValue.message ?? "empty message" ,  productModelList);
      },)
    );
  }


  Widget buildProductModelList(Status status , String message, List<Products>? productModelList){
     print("status state : "+status.toString());
    switch(status){
      case Status.loading:
        return Center(child: const Text("loading", ));
      case Status.error:
        return Center(child: Text(message, ));
      case Status.completed:
        return ListView.builder(
          itemCount: productModelList!.length ?? 0,
          itemBuilder: (context, index) {
          return ListTile(
            title: Text(productModelList![index].title.toString() ),
            subtitle: Text(productModelList[index].description?.toString() ?? ''),
            leading: Image.network(productModelList[index].thumbnail.toString(), errorBuilder: (context, error, stackTrace) {
              return Text("errorImage");
            }, fit: BoxFit.contain, width: 80, height: 80,),
          );
        },);
    }
  }
}
