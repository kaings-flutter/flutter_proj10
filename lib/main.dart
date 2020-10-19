import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './presentation/router/app_router.dart';
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
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (ctx) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: _appRouter.onGeneraRoute,
      ),
    );
  }
}
