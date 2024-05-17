import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentations/pages/albums_page.dart';
import '../presentations/pages/home_page.dart';
import '../presentations/pages/login_page.dart';
import '../presentations/pages/settings_page.dart';
import '../presentations/pages/splash_page.dart';
import '../route/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domains/domains.dart';
import '../presentations/pages/album_page.dart';
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
      initialLocation: Routes.splash,
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        GoRoute(
          path: Routes.splash,
          name: Routes.splash.name,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: Routes.login,
          name: Routes.login.name,
          builder: (context, state) => const LoginPage(),
        ),
        StatefulShellRoute.indexedStack(
            builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
              return ScaffoldWithNavBar(navigationShell: navigationShell);
            },
            branches: <StatefulShellBranch>[
              StatefulShellBranch(navigatorKey: _sectionMainNavKey, routes: <RouteBase>[
                GoRoute(
                    path: Routes.home,
                    name: Routes.home.name,
                    pageBuilder: (context, state) => const NoTransitionPage(child: HomePage()),
                    routes: [
                      GoRoute(
                          path: Routes.albums.name,
                          name: Routes.albums.name,
                          pageBuilder: (
                              BuildContext context,
                              GoRouterState router,
                              ) =>
                          const NoTransitionPage(
                            child: AlbumsPage(),
                          ),
                          routes: [
                            GoRoute(
                                path: Routes.album.name,
                                name: Routes.album.name,
                              builder: (context, state) {
                                final params = state.extra! as Map<String, dynamic>;
                                final album = params['album'] is ItemEntity
                                    ? params['album'] as ItemEntity
                                    : ItemEntity.fromJson(params['album'] as Map<String, dynamic>);
                              return  AlbumPage(album: album);
                              }
                            )
                          ],

                      ),
                    ]),
              ]),
              StatefulShellBranch(routes: <RouteBase>[
                GoRoute(
                  path: Routes.settings,
                  name: Routes.settings.name,
                  builder: (context, state) => const SettingsPage(),
                ),
              ]),
            ]),
      ],
      redirect: (context, state) {
        if (isAuth.value.unwrapPrevious().hasError) return Routes.login;
        if (isAuth.value.isLoading || !isAuth.value.hasValue) return Routes.splash;

        final auth = isAuth.value.requireValue;

        final isSplash = state.uri.path == Routes.splash;
        if (isSplash) return auth ? Routes.home : Routes.login;
        final isLoggingIn = state.uri.path == Routes.login;
        if (isLoggingIn) return auth ? Routes.home : null;
        return auth ? null : Routes.splash;
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
