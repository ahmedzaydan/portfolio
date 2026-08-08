import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../extensions/context_extension.dart';

part 'app_router.g.dart';

final GoRouter appRouter = GoRouter(initialLocation: '/', routes: $appRoutes);

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio'),
        actions: [
          TextButton(
            onPressed: () => context.cubit.toggleLanguage(),
            child: const Text("Toogle Language"),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome to my Portfolio!',
          style: context.textStyles.bodyLarge,
        ),
      ),
    );
  }
}
