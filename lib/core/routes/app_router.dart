import 'package:go_router/go_router.dart';
import 'package:worktracker/core/routes/app_navigator.dart';
import 'package:worktracker/core/routes/routes_name.dart';
import 'package:worktracker/features/auth/presentation/page/sign_in_page.dart';
import 'package:worktracker/features/home/presentation/page/home_page.dart';
import 'package:worktracker/features/splash/presentation/page/maintenance_page.dart';
import 'package:worktracker/features/splash/presentation/page/splash_page.dart';

final appRouter = GoRouter(
  initialLocation: RoutesName.splash,
  debugLogDiagnostics: true,
  navigatorKey: AppNavigator.navigationKey,
  routes: [
    GoRoute(
      path: RoutesName.splash,
      name: RoutesName.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RoutesName.signIn,
      name: RoutesName.signIn,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: RoutesName.maintenance,
      name: RoutesName.maintenance,
      builder: (context, state) => const MaintenancePage(),
    ),
    GoRoute(
      path: RoutesName.home,
      name: RoutesName.home,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
