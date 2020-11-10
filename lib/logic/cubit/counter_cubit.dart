import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../constants/enums.dart';
import './internet_cubit.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  StreamSubscription internetStreamSub;

  // when there is WIFI connection, increase the state by 1
  // when there is MOBILE connection (no WIFI), decrease the state by 1
  CounterCubit({@required this.internetCubit})
      : super(CounterState(counterValue: 0)) {
    monitorInternetCubit();
  }

  StreamSubscription<InternetState> monitorInternetCubit() {
    return internetStreamSub = internetCubit.listen((internetState) {
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.WIFI) {
        increment();
      } else if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.MOBILE) {
        decrement();
      }
    });
  }

  void increment() => emit(CounterState(
        counterValue: state.counterValue + 1,
        isIncremented: true,
      ));

  void decrement() => emit(CounterState(
        counterValue: state.counterValue - 1,
        isIncremented: false,
      ));

  // we need to manually close the subscription
  @override
  Future<void> close() {
    internetStreamSub.cancel();
    return super.close();
  }
}
