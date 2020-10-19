import 'package:flutter/material.dart';
import '../screen/home_screen.dart';
import '../screen/second_screen.dart';
import '../screen/third_screen.dart';

class AppRouter {
  Route onGeneraRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (ctx) => HomeScreen(
            title: 'Home Screen',
            color: Colors.blueAccent,
          ),
        );
        break;
      case SecondScreen.routeName:
        return MaterialPageRoute(
          builder: (ctx) => SecondScreen(
            title: 'Second Screen',
            color: Colors.redAccent,
          ),
        );
        break;
      case ThirdScreen.routeName:
        return MaterialPageRoute(
          builder: (ctx) => ThirdScreen(
            title: 'Third Screen',
            color: Colors.greenAccent,
          ),
        );
        break;
      default:
        return null;
    }
  }
}
