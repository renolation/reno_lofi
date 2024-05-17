import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reno_music/presentations/pages/album_page.dart';
import 'package:reno_music/presentations/pages/home_page.dart';
import 'package:reno_music/presentations/pages/login_page.dart';
import 'package:reno_music/presentations/pages/settings_page.dart';
import 'package:reno_music/presentations/pages/splash_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/auth_controller.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionMainNavKey = GlobalKey<NavigatorState>(debugLabel: 'sectionMainNav');

@riverpod
GoRouter router(RouterRef ref) {
  final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());

  ref
    ..onDispose(isAuth.dispose) // don't forget to clean after yourselves (:
    // update the listenable, when some provider value changes
    // here, we are just interested in wheter the user's logged in
    ..listen(
      authControllerProvider.select((value) => value.whenData((value) => value.isAuth)),
      (_, next) {
        isAuth.value = next;
      },
    );

  final router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      refreshListenable: isAuth,
      initialLocation: '/splash',
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        GoRoute(
          path: '/splash',
          name: 'splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        StatefulShellRoute.indexedStack(
            builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
              return ScaffoldWithNavBar(navigationShell: navigationShell);
            },
            branches: <StatefulShellBranch>[
              StatefulShellBranch(navigatorKey: _sectionMainNavKey, routes: <RouteBase>[
                GoRoute(
                    path: '/home',
                    name: 'home',
                    pageBuilder: (context, state) => const NoTransitionPage(child: HomePage()),
                    routes: [
                      GoRoute(
                          path: 'albums',
                          name: 'albums',
                          pageBuilder: (
                            BuildContext context,
                            GoRouterState router,
                          ) {
                            return const NoTransitionPage(
                              child: AlbumPage(),
                            );
                          }),
                    ]),
              ]),
              StatefulShellBranch(routes: <RouteBase>[
                GoRoute(
                  path: '/settings',
                  name: 'settings',
                  builder: (context, state) => const SettingsPage(),
                ),
              ]),
            ]),
      ],
      redirect: (context, state) {
        if (isAuth.value.unwrapPrevious().hasError) return '/login';
        if (isAuth.value.isLoading || !isAuth.value.hasValue) return '/splash';

        final auth = isAuth.value.requireValue;

        final isSplash = state.uri.path == '/splash';
        if (isSplash) return auth ? '/home' : '/login';
        final isLoggingIn = state.uri.path == '/login';
        if (isLoggingIn) return auth ? '/home' : null;
        return auth ? null : '/splash';
      });
  ref.onDispose(router.dispose);
  return router;
}

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Section A'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Section B'),
          BottomNavigationBarItem(icon: Icon(Icons.tab), label: 'Section C'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
