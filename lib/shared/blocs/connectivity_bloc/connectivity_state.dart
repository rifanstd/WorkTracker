import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object?> get props => [];
}

final class ConnectivityInitial extends ConnectivityState {}

final class ConnectivityConnected extends ConnectivityState {
  final List<ConnectivityResult> connectivityResults;
  final String connectionType;

  const ConnectivityConnected({
    required this.connectivityResults,
    required this.connectionType,
  });

  @override
  List<Object?> get props => [
        connectivityResults,
        connectionType,
      ];
}

final class ConnectivityDisconnected extends ConnectivityState {}
