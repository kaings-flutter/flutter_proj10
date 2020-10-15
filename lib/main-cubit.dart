import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

void main(List<String> args) {
  final counterCubit = CounterCubit();

  // demonstrate cubit is a Stream with
  // FUNCTION as trigger & output the state

  // initial state value: 0
  print(counterCubit.state);

  // incremental
  counterCubit.increment();
  print(counterCubit.state);

  counterCubit.increment();
  print(counterCubit.state);

  counterCubit.increment();
  print(counterCubit.state);

  // decremental
  counterCubit.decrement();
  print(counterCubit.state);

  counterCubit.decrement();
  print(counterCubit.state);

  counterCubit.decrement();
  print(counterCubit.state);
}
