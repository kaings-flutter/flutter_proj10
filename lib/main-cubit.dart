import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

void main(List<String> args) async {
  final counterCubit = CounterCubit();

  // demonstrate cubit is a Stream with
  // FUNCTION as trigger & output the state

  // // initial state value: 0
  // print(counterCubit.state);

  // // incremental
  // counterCubit.increment();
  // print(counterCubit.state);

  // counterCubit.increment();
  // print(counterCubit.state);

  // counterCubit.increment();
  // print(counterCubit.state);

  // // decremental
  // counterCubit.decrement();
  // print(counterCubit.state);

  // counterCubit.decrement();
  // print(counterCubit.state);

  // counterCubit.decrement();
  // print(counterCubit.state);

  // since cubit is a Stream, we can listen by subscribing to it
  final counterCubitSub = counterCubit.listen(print);

  counterCubit.increment();
  counterCubit.decrement();
  counterCubit.increment();
  counterCubit.increment();
  counterCubit.increment();

  // this is because we do not want to cancel the subscription immediately
  // below code
  await Future.delayed(Duration.zero);

  // since it is Stream & subscription of Stream,
  // we need to cancel/close it to avoid memory leak
  // for flutter_bloc, flutter_bloc handles the closing of
  // subscriptions & stream automatically for us
  await counterCubitSub.cancel();
  await counterCubit.close();
}
