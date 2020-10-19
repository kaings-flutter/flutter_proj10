import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './presentation/screen/home_screen.dart';
import './presentation/screen/second_screen.dart';
import './presentation/screen/third_screen.dart';
import './logic/cubit/counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // we will use only ONE UNIQUE Cubit. Therefore,
  // we need to pass using BlocProvider.value
  // But, since we instantiate it manually, we also need to manually dispose it
  // to avoid memory leaks
  // ** if create instance using BlocProvider(create: ...), BlocProvider will automatically
  //    close it for us. But, in this case, we cannot use it because it will create new instance
  //    for each route. In this case, we use BlocProvider.value
  // ** in order to close it namually, we need to convert to StatefulWidget override dispose()
  final _counterCubit = CounterCubit();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        HomeScreen.routeName: (ctx) => BlocProvider.value(
              // we CANNOT use the following.
              // ** context.bloc<CounterCubit>() is used when we use BlocProvider where
              //    CounterCubit provider will be created automatically
              // ** since we create CounterCubit manually here, we can simply pass
              //    the created instance

              // value: context.bloc<CounterCubit>(),
              value: _counterCubit,
              child: HomeScreen(
                title: 'Home Screen',
                color: Colors.blueAccent,
              ),
            ),
        SecondScreen.routeName: (ctx) => BlocProvider.value(
              // value: context.bloc<CounterCubit>(),
              value: _counterCubit,
              child: SecondScreen(
                title: 'Second Screen',
                color: Colors.redAccent,
              ),
            ),
        ThirdScreen.routeName: (ctx) => BlocProvider.value(
              // value: context.bloc<CounterCubit>(),
              value: _counterCubit,
              child: ThirdScreen(
                title: 'Third Screen',
                color: Colors.greenAccent,
              ),
            ),
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Since we instantiate it manually, we also need to manually dispose it
    // to avoid memory leaks
    _counterCubit.close();
  }
}
