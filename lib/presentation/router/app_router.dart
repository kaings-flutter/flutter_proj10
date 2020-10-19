import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/counter_cubit.dart';
import '../screen/home_screen.dart';
import '../screen/second_screen.dart';
import '../screen/third_screen.dart';

class AppRouter {
  final CounterCubit _counterCubit = CounterCubit();

  Route onGeneraRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider.value(
            value: _counterCubit,
            child: HomeScreen(
              title: 'Home Screen',
              color: Colors.blueAccent,
            ),
          ),
        );
        break;
      case SecondScreen.routeName:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider.value(
            value: _counterCubit,
            child: SecondScreen(
              title: 'Second Screen',
              color: Colors.redAccent,
            ),
          ),
        );
        break;
      case ThirdScreen.routeName:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider.value(
            value: _counterCubit,
            child: ThirdScreen(
              title: 'Third Screen',
              color: Colors.greenAccent,
            ),
          ),
        );
        break;
      default:
        return null;
    }
  }

  void displose() {
    _counterCubit.close();
  }
}
