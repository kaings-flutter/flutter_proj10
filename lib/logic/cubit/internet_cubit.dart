import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../constants/enums.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription connectivityStreamSub;

  InternetCubit({@required this.connectivity}) : super(InternetLoading()) {
    connectivityStreamSub =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        print('Connectivity WIFI.....');
        emitInternetConnected(ConnectionType.WIFI);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        print('Connectivity MOBILE.....');
        emitInternetConnected(ConnectionType.MOBILE);
      } else if (connectivityResult == ConnectivityResult.none) {
        print('Connectivity NONE.....');
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType _connectionType) =>
      emit(InternetConnected(connectionType: _connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  // we need to manually close the subscription
  @override
  Future<void> close() {
    connectivityStreamSub.cancel();
    return super.close();
  }
}
