import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reno_music/presentations/pages/home_page.dart';
import 'package:reno_music/presentations/pages/login_page.dart';
import 'package:reno_music/presentations/pages/splash_page.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(path: '/',)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state){
    return const HomePage();
  }
}

@TypedGoRoute<SplashRoute>(path: '/splash')
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state){
    return const SplashPage();
  }
}
@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

class UserRoute extends GoRouteData {
  const UserRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashPage();
  }
}