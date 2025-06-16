import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object?> get props => [];
}

final class ConnectivityChanged extends ConnectivityEvent {
  final List<ConnectivityResult> connectivityResults;

  const ConnectivityChanged({required this.connectivityResults});

  @override
  List<Object?> get props => [connectivityResults];
}
