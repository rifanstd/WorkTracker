import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:worktracker/core/utils/logging/logger.dart';
import 'package:worktracker/features/auth/domain/usecases/get_signed_user.dart';
import 'package:worktracker/features/splash/domain/usecases/get_android_play_store_url.dart';
import 'package:worktracker/features/splash/domain/usecases/get_app_latest_version.dart';
import 'package:worktracker/features/splash/domain/usecases/get_ios_app_store_url.dart';
import 'package:worktracker/features/splash/domain/usecases/get_maintenance_status.dart';
import 'package:worktracker/features/splash/presentation/bloc/splash_event.dart';
import 'package:worktracker/features/splash/presentation/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetAppLatestVersion getAppLatestVersion;
  final GetAndroidPlayStoreUrl getAndroidPlayStoreUrl;
  final GetiOSAppStoreUrl getiOSAppStoreUrl;
  final GetMaintenanceStatus getMaintenanceStatus;
  final GetSignedUser getSignedUser;

  SplashBloc({
    required this.getAppLatestVersion,
    required this.getSignedUser,
    required this.getAndroidPlayStoreUrl,
    required this.getiOSAppStoreUrl,
    required this.getMaintenanceStatus,
  }) : super(SplashInitial()) {
    on<CheckAppVersion>(_onCheckAppVersion);
    on<CheckMaintenance>(_onCheckMaintenance);
    on<CheckSignedInUser>(_onCheckSignedInUserRequested);
  }

  Future<void> _onCheckAppVersion(CheckAppVersion event, Emitter<SplashState> emit) async {
    emit(SplashLoading());
    try {
      AppLogger.info('[SPLASH BLOC] CheckAppVersion');
      final info = await PackageInfo.fromPlatform();
      final currentVersion = info.version;
      AppLogger.info('[SPLASH BLOC] Current version: $currentVersion');

      final latestVersion = getAppLatestVersion();
      AppLogger.info('[SPLASH BLOC] Latest version: $latestVersion');

      if (latestVersion == currentVersion) {
        AppLogger.info('[SPLASH BLOC] App is up to date');
        emit(AppVersionUpToDate(version: latestVersion));
      } else {
        AppLogger.info('[SPLASH BLOC] App is outdated');
        final androidPlayStoreUrl = getAndroidPlayStoreUrl();
        final iOSAppStoreUrl = getiOSAppStoreUrl();
        AppLogger.info('[SPLASH BLOC] Android Play Store URL: $androidPlayStoreUrl');
        AppLogger.info('[SPLASH BLOC] iOS App Store URL: $iOSAppStoreUrl');
        emit(
          AppVersionOutdated(
            version: latestVersion,
            androidPlayStoreUrl: androidPlayStoreUrl,
            iOSAppStoreUrl: iOSAppStoreUrl,
          ),
        );
      }
    } on Exception catch (e, stack) {
      AppLogger.error('[SPLASH BLOC] CheckAppVersion failed', e, stack);
      emit(SplashError(e.toString()));
    }
  }

  Future<void> _onCheckMaintenance(
    CheckMaintenance event,
    Emitter<SplashState> emit,
  ) async {
    try {
      AppLogger.info('[SPLASH BLOC] CheckMaintenance');
      final isMaintenance = getMaintenanceStatus();
      if (isMaintenance) {
        AppLogger.info('[SPLASH BLOC] App is in maintenance mode');
        emit(const AppMaintenance());
      } else {
        AppLogger.info('[SPLASH BLOC] App is not in maintenance mode');
        add(const CheckSignedInUser());
      }
    } on Exception catch (e, stack) {
      AppLogger.error('[SPLASH BLOC] CheckMaintenance failed', e, stack);
      emit(SplashError(e.toString()));
    }
  }

  Future<void> _onCheckSignedInUserRequested(
    CheckSignedInUser event,
    Emitter<SplashState> emit,
  ) async {
    try {
      AppLogger.info('[SPLASH BLOC] AuthCheckRequested');
      final user = await getSignedUser();
      if (user != null) {
        AppLogger.info('[SPLASH BLOC] User is authenticated: ${user.email}');
        emit(UserSignedIn(user: user));
      } else {
        AppLogger.info('[SPLASH BLOC] No user is signed in');
        emit(const UserNotSignedIn());
      }
    } on Exception catch (e, stack) {
      AppLogger.error('[SPLASH BLOC] CheckSignedInUser failed', e, stack);
      emit(SplashError(e.toString()));
    }
  }
}
