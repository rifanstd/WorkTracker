import 'package:go_router/go_router.dart';
import 'package:worktracker/config/routes/route_names.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  routes: [
    GoRoute(path: RouteNames.splash),
    GoRoute(path: RouteNames.login),
    GoRoute(path: RouteNames.home),
  ],
);
