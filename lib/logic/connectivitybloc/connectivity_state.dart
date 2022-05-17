part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {}

class ConnectionInitial extends ConnectivityState {}

class ConnectionSuccess extends ConnectivityState {}

class ConnectionFailure extends ConnectivityState {}
