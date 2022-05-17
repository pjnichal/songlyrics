import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  late StreamSubscription _subscription;
  final Connectivity _connectivity = Connectivity();
  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<ConnectivityEvent>((event, emit) async {
      if (event is InitialListenConnection) {
        var result = await _connectivity.checkConnectivity();

        if (result == ConnectivityResult.none) {
          add(ConnectionChanged(ConnectionFailure()));
        }
      }

      if (event is ListenConnection) {
        _subscription = _connectivity.onConnectivityChanged.listen((event) {
          print(event);
          add(ConnectionChanged((event == ConnectivityResult.none
              ? ConnectionFailure()
              : ConnectionSuccess())));
        });
      }
      if (event is ConnectionChanged) emit(event.connection);
    });
  }
}

class ConnectivityChanged {
  ConnectivityChanged(ConnectionFailure connectionFailure);
}
