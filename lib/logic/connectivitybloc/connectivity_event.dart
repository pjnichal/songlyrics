part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityEvent {}

class ListenConnection extends ConnectivityEvent {}

class InitialListenConnection extends ConnectivityEvent {}

class ConnectionChanged extends ConnectivityEvent {
  ConnectivityState connection;
  ConnectionChanged(this.connection);
}
