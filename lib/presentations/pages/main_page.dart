import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reno_music/presentations/widgets/custom_navigation_rail.dart';
import 'package:reno_music/state/auth_controller.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../resources/resources.dart';
import '../widgets/bottom_player.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key =  const ValueKey<String>('ScaffoldWithNavBar'), required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {

  late ThemeData _theme;
  late Size _screenSize;
  late bool _isMobile;
  late bool _isTablet;
  late bool _isDesktop;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    _theme = Theme.of(context);
    _screenSize = MediaQuery.sizeOf(context);

    final deviceType = getDeviceType(_screenSize);
    _isMobile = deviceType == DeviceScreenType.mobile;
    _isTablet = deviceType == DeviceScreenType.tablet;
    _isDesktop = deviceType == DeviceScreenType.desktop;
  }


  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.navigationShell.currentIndex;
    return Scaffold(
      body: Row(
        children: [
          Visibility(
                visible: _isDesktop,
              child: CustomNavigationRail(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                selectedItemColor: _theme.colorScheme.primary,
                unselectedItemColor: _theme.colorScheme.onPrimary,
                selectedFontSize: 16,
                unselectedFontSize: 16,
                leading: const Text(
                  'JellyBox',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: TextButton.icon(
                  onPressed: () {
                    ref.read(authControllerProvider.notifier).logout();
                  },
                  icon: const Icon(JPlayer.log_out),
                  label: const Text('Log out'),
                ),
                selectedIndex: currentIndex,
                onDestinationSelected: _onTap,
                destinations: List.generate(
                  _menuItems.length,
                      (index) => NavigationRailDestination(
                    icon: Icon(_menuItems.elementAt(index).$1),
                    label: Text(_menuItems.elementAt(index).$2),
                    indicatorColor: const Color(0xFF341010),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                  ),
                ),
              )),
          Expanded(
            child: Column(
              children: [
                Expanded(child: widget.navigationShell,),
                const BottomPlayer(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: !_isDesktop,
        child: BottomNavigationBar(
          iconSize: _isMobile ? 28 : 24,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Section A'),
            BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Section B'),
            BottomNavigationBarItem(icon: Icon(Icons.tab), label: 'Section C'),
          ],
          currentIndex: widget.navigationShell.currentIndex,
          onTap: _onTap,
        ),
      ),
    );
  }

  Set<(IconData, String)> get _menuItems => {
    (JPlayer.play_circle_outlined, 'Listen'),
    (JPlayer.search, 'Search'),
    (JPlayer.settings, 'Settings'),
    // (JPlayer.download, 'Downloads'),
  };


  void _onTap(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
