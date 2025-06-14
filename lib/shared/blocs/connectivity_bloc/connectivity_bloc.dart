import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worktracker/core/utils/logging/logger.dart';
import 'package:worktracker/shared/blocs/connectivity_bloc/connectivity_event.dart';
import 'package:worktracker/shared/blocs/connectivity_bloc/connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    AppLogger.info('[CONNECTIVITY BLOC] ConnectivityBloc initialized');
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    on<ConnectivityChanged>((event, emit) async {
      final connectivityResults = event.connectivityResults;
      AppLogger.info(
          '[CONNECTIVITY BLOC] ConnectivityChanged event received: ${connectivityResults.join(', ')}');

      if (connectivityResults.contains(ConnectivityResult.none)) {
        AppLogger.error('[CONNECTIVITY BLOC] No connectivity detected');
        emit(ConnectivityDisconnected());
      } else {
        AppLogger.info('[CONNECTIVITY BLOC] Connectivity detected: ${connectivityResults.join(', ')}');
        final connectionType = connectivityResults.first.toString().split('.').last;
        emit(
          ConnectivityConnected(
            connectivityResults: connectivityResults,
            connectionType: connectionType,
          ),
        );
      }
    });
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    add(ConnectivityChanged(connectivityResults: result));
  }

  @override
  Future<void> close() async {
    await _connectivitySubscription.cancel();
    await super.close();
  }
}
