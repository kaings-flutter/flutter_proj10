import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './cubit/counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // when deal with multiple BlocProvider

    // MultiBlocProvider(
    //   providers: [
    //     BlocProvider<BlocA>(
    //       create: (BuildContext context) => BlocA(),
    //     ),
    //     BlocProvider<BlocB>(
    //       create: (BuildContext context) => BlocB(),
    //     ),
    //     BlocProvider<BlocC>(
    //       create: (BuildContext context) => BlocC(),
    //     ),
    //   ],
    //   child: ChildAEtcEtc(),
    // );

    // ==============================================================

    // when deal with multiple RepositoryProvider

    // MultiRepositoryProvider(
    //   providers: [
    //     RepositoryProvider<RepositoryA>(
    //       create: (BuildContext context) => RepositoryA(),
    //     ),
    //     RepositoryProvider<RepositoryB>(
    //       create: (BuildContext context) => RepositoryB(),
    //     ),
    //     RepositoryProvider<RepositoryC>(
    //       create: (BuildContext context) => RepositoryC(),
    //     ),
    //   ],
    //   child: ChildAEtcEtc(),
    // );

    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(
          title: 'Flutter Demo Home Page',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // BlocListener vs BlocBuilder
      // ================================================================
      // <BlocBuilder>
      // - `builder` function will rebuild widgets under it
      // - this `builder` function may be called MULTIPLE TIMES PER STATE
      //   causing REBUILD MULTIPLE TIMES. Therefore, not recommended for
      //   complex widget to use such as `SnackBar`. e.g. 5x rebuild will cause
      //   5x of Snackbar rebuild
      // - has `buildWhen` function as well
      // ================================================================
      // <BlocListener>
      // - some widget(s) can be put under it to listen to state.
      //   Widget will be build depends on the state.
      // - `listener` function will be called only ONCE PER STATE
      //    (Excluding INITIAL STATE)
      // - has `listenWhen` function as well

      // BlocConsumer is the combination of BlocListener + BlocBuilder

      // when dealing with multiple BlocListener/BlocBuilder
      // MultiBlocListener(
      //   listeners: [
      //     BlocListener<BlocA, BlocAState>(
      //       listener: (context, state) {},
      //     ),
      //     BlocListener<BlocB, BlocBState>(
      //       listener: (context, state) {},
      //     ),
      //     BlocListener<BlocC, BlocCState>(
      //       listener: (context, state) {},
      //     ),
      //   ],
      //   child: ChildAEtcEtc(),
      // );

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            SizedBox(
              height: 20,
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (ctx, state) {
                if (state.isIncremented == true) {
                  Scaffold.of(ctx).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Increment !!!!!',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(milliseconds: 500),
                    ),
                  );
                } else if (state.isIncremented == false) {
                  Scaffold.of(ctx).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Decrement !!!!!',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(milliseconds: 500),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Text(
                  '${state.counterValue.toString()} ${state.counterValue < 0 ? '(below 0)' : ''}',
                  style: Theme.of(context).textTheme.headline5,
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                    child: Icon(Icons.remove),
                    tooltip: 'Decrement',
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                      // OR the following also works
                      // context.bloc<CounterCubit>().decrement();
                    }),
                FloatingActionButton(
                    child: Icon(Icons.add),
                    tooltip: 'Increment',
                    onPressed: () {
                      context.bloc<CounterCubit>().increment();
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
