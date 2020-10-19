import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './second_screen.dart';
import '../../logic/cubit/counter_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
      ),
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
                    backgroundColor: widget.color,
                    // `heroTag` is needed if you use multiple FloatingActionButton to
                    // avoid error "multiple heroes that share the same tag within a subtree"
                    heroTag: Text('${widget.title} #min'),
                    child: Icon(Icons.remove),
                    tooltip: 'Decrement',
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                      // OR the following also works
                      // context.bloc<CounterCubit>().decrement();
                    }),
                FloatingActionButton(
                    backgroundColor: widget.color,
                    // `heroTag` is needed if you use multiple FloatingActionButton to
                    // avoid error "multiple heroes that share the same tag within a subtree"
                    heroTag: Text('${widget.title} #dd'),
                    child: Icon(Icons.add),
                    tooltip: 'Increment',
                    onPressed: () {
                      context.bloc<CounterCubit>().increment();
                    }),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            MaterialButton(
              color: widget.color,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<SecondScreen>(
                    // BlocProvider wont know about SecondScreen.
                    // we need to pass the value of the provider (instead of
                    // creating new instance) so that it is still ONE SAME UNIQUE
                    // provider that is on HomeScreen

                    // **If you create new instance (value: CounterCubit()),
                    //   it will be totally new instance (not the one in HomeScreen)
                    // **Since we pass the value from the provider, the provider in
                    //   SecondScreen still the SAME provider on HomeScreen (sharing same value)

                    builder: (ctx) => BlocProvider.value(
                      // we also need to use `context` of HomeScreen
                      // using `ctx` (context of builder) will create new instance
                      value: BlocProvider.of<CounterCubit>(context),
                      child: SecondScreen(
                        title: 'Second Screen',
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                );
              },
              child: Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
