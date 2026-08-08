import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../portfolio/presentation/screens/home_screen.dart';

part 'app_router.g.dart';

final GoRouter appRouter = GoRouter(initialLocation: '/', routes: $appRoutes);

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}
