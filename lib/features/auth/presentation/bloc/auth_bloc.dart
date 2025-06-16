import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worktracker/core/utils/logging/logger.dart';
import 'package:worktracker/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:worktracker/features/auth/domain/usecases/sign_out.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_event.dart';
import 'package:worktracker/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogle signInWithGoogle;
  final SignOut signOut;

  AuthBloc({required this.signInWithGoogle, required this.signOut}) : super(AuthInitial()) {
    on<AuthSignInWithGoogle>(_onAuthSignInWithGoogle);
    on<AuthSignOut>(_onAuthSignOut);
  }

  Future<void> _onAuthSignInWithGoogle(AuthSignInWithGoogle event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      AppLogger.info('[AUTH BLOC] SignInWithGoogle requested');
      final user = await signInWithGoogle();
      AppLogger.info('[AUTH BLOC] User signed in: ${user.email}');
      emit(Authenticated(user));
    } on Exception catch (e, stack) {
      AppLogger.error('[AUTH BLOC] SignInWithGoogle failed', e, stack);
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      AppLogger.info('[AUTH BLOC] SignOut requested');
      await signOut();
      AppLogger.info('[AUTH BLOC] User signed out');
      emit(const Unauthenticated());
    } on Exception catch (e, stack) {
      AppLogger.error('[AUTH BLOC] SignOut failed', e, stack);
      emit(AuthError(e.toString()));
    }
  }
}
