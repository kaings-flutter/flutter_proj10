import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/counter_cubit.dart';
import './third_screen.dart';

class SecondScreen extends StatefulWidget {
  static const routeName = '/second-screen';

  SecondScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
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
                    heroTag: Text('${widget.title} #add'),
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
                Navigator.of(context).pushNamed(ThirdScreen.routeName);
              },
              child: Text('Go to Third Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
