import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/home_screen/presentations/home_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();


enum AppRoute{
  home
}

final goRouterProvider = Provider<GoRouter>((ref) {
return GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',

  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
});