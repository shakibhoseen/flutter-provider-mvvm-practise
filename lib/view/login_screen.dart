import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/network/network_api_services.dart';
import 'package:flutter_mvvm/res/component/rounded_button.dart';
import 'package:flutter_mvvm/res/urls.dart';
import 'package:flutter_mvvm/utils/utils.dart';
import 'package:flutter_mvvm/view_model/auth_viewmodel.dart';
import 'package:flutter_svg/src/picture_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  ValueNotifier<bool> _obsecurepassword = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (p0, p1) {
            return (Stack(
              children: [
                SizedBox(
                  height: p1.maxHeight / 2,
                  child: SvgPicture.asset(
                    "assets/images/bg5.svg",
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                    height: p1.maxHeight,
                    width: p1.maxWidth,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: design(p1.maxHeight,authViewModel,  context))
              ],
            ));
          },
        ),
      ),
    );
  }

  Widget design(double height,AuthViewModel authViewModel,  BuildContext context) {
    return Column(
      //mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Log In",
          style: GoogleFonts.firaSans(
              fontSize: 33,
              color: Colors.green.shade700,

              fontWeight: FontWeight.w800),
        ),
        TextFormField(

          controller: _emailController,
          focusNode: emailNode,
          decoration: const InputDecoration(
            hintText: "Enter your email",
            labelText: "Email",
            prefixIcon: Icon(Icons.alternate_email),
          ),
          onFieldSubmitted: (value) {
            Utils.fieldFocusChanged(context, emailNode, passwordNode);
          },
        ),
        ValueListenableBuilder(
          valueListenable: _obsecurepassword, builder: (context, value, child) {
          return TextFormField(
            controller: _passwordController,
            focusNode: passwordNode,
            obscureText: value,
            decoration: InputDecoration(
              hintText: "Enter your password",
              labelText: "Password",
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: InkWell(
                onTap: (){
                  _obsecurepassword.value = !_obsecurepassword.value;
                },
                child: value ?const Icon(Icons.visibility_off) :const Icon(Icons.remove_red_eye),
              )
            ),
          );
        },),
        SizedBox(height: height*.1,),
        RoundedButton(title: "Log in", onPress: (){
          Map data = {
            'username': _emailController.text.toString(),
            'password': _passwordController.text.toString(),
            //'device_id': '1223'
          };
         // Map data = {"data": "good morning1"};
          authViewModel.logInApi(data, context);
          //final model = NetworkAPiServices();
          // model.postAPiResponse(Urls.logInEndPoint, data).then((value) => print("value direct"+value));

          if (kDebugMode) {
            print("api hit");
          }
        }, isLoading: authViewModel.loading ),
      ],
    );
  }
}
