import 'package:flutter/material.dart';
import 'package:worktracker/core/di/injection_container.dart';
import 'package:worktracker/shared/presentation/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:worktracker/shared/presentation/blocs/connectivity_bloc/connectivity_state.dart';

class ConnectivityHelper {
  ConnectivityHelper._();

  static bool isConnected(BuildContext context) {
    final connectivityState = sl<ConnectivityBloc>().state;
    return connectivityState is ConnectivityConnected;
  }
}
