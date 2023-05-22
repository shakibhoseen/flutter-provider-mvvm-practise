import 'package:flutter/material.dart';
import 'package:flutter_mvvm/utils/route/routes_name.dart';
import 'package:flutter_mvvm/view/login_screen.dart';
import 'package:flutter_mvvm/view/splash_screen.dart';

import '../../view/home_screen.dart';

class Routes {
  static MaterialPageRoute genarateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RoutesName.loginScreen:
        return MaterialPageRoute(
          builder: (context) =>  const LoginScreen(),
        );
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen(),);
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("No page route define"),
            ),
          );
        });
    }
  }
}
