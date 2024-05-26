import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reno_music/presentations/views/library_view.dart';
import 'package:reno_music/state/auth_controller.dart';
import 'package:reno_music/state/scrollable_page_scaffold.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../data/list_library_provider.dart';
import '../../domains/domains.dart';
import '../../state/secure_storage_provider.dart';
import '../resources/resources.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final future = useMemoized(() => ref.read(jellyfinApiProvider).getLibraries(userId: userId));
    // final snapshot = useFuture(future);

    final screenSize = MediaQuery.sizeOf(context);
    final deviceType = getDeviceType(screenSize);
    final isMobile = deviceType == DeviceScreenType.mobile;
    final isTablet = deviceType == DeviceScreenType.tablet;
    final isDesktop = deviceType == DeviceScreenType.desktop;

    Consumer(builder: (context, ref, child) {
      final data = ref.watch(listLibraryProviderProvider);
      return data.when(
        data: (data) {
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final LibraryEntity entity = data[index];
                return InkWell(
                    onTap: () async {
                      ref
                          .read(selectingLibraryControllerProvider.notifier)
                          .setSelectLibrary(entity)
                          .then((value) => context.goNamed('albums'));
                    },
                    child: Card(child: Container(child: Text(data[index].name!))));
              });
        },
        error: (err, stack) => Text('Error $err'),
        loading: () => const Text('loading'),
      );
    });

    return ScrollablePageScaffold(
      useGradientBackground: true,
      navigationBar: PreferredSize(
        preferredSize: Size.fromHeight(isMobile ? 48 : 100),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 30),
          child: Row(
            children: [
              CircleAvatar(
                radius: isDesktop ? 22.5 : 13,
              ),
              const SizedBox(width: 10),
              _titleText(),
              const Spacer(),
              _searchButton(),
              if (kDebugMode)
                TextButton(
                    onPressed: () => {ref.read(authControllerProvider.notifier).logout()}, child: const Text('Logout'))
            ],
          ),
        ),
      ),
      contentPadding: EdgeInsets.only(
        left: isMobile ? 16 : 30,
        right: isMobile ? 16 : 30,
        bottom: isMobile ? 8 : 20,
      ),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(
            left: isMobile ? 16 : 30,
            right: isMobile ? 16 : 30,
          ),
          sliver: Consumer(builder: (context, ref, child) {
            final data = ref.watch(listLibraryProviderProvider);
            return data.when(
              data: (data) {
                return SliverGrid.builder(
                    gridDelegate: isDesktop || isTablet
                        ? SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: isTablet ? 370 : 358,
                      mainAxisSpacing: isMobile ? 13 : 34,
                      crossAxisSpacing: isDesktop ? 24 : (isMobile ? 16 : 34),
                      childAspectRatio: 16/9,
                    )
                        : const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisExtent: 250),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final LibraryEntity entity = data[index];
                      return LibraryView(library: entity,
                        onTap: () async {
                          ref
                              .read(selectingLibraryControllerProvider.notifier)
                              .setSelectLibrary(entity)
                              .then((value) => context.goNamed('albums'));
                        },
                      );
                    });
              },
              error: (err, stack) => SliverToBoxAdapter(
                child: Text('Error: $err'),
              ),
              loading: () =>  const SliverToBoxAdapter(
                child: SpinKitChasingDots( color: Colors.white,),
              ),
            );
          }),
          // sliver: SliverGrid.builder(
          //   gridDelegate: isDesktop || isTablet
          //       ? SliverGridDelegateWithMaxCrossAxisExtent(
          //     maxCrossAxisExtent: isTablet ? 370 : 358,
          //     mainAxisSpacing: isMobile ? 13 : 34,
          //     crossAxisSpacing: isDesktop ? 24 : (isMobile ? 16 : 34),
          //     childAspectRatio: 370 / 255,
          //   )
          //       : const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisExtent: 250),
          //   itemBuilder: (context, index) => LibraryView(
          //     library: libraries[index],
          //     onTap: () => _onLibraryTap(libraries[index]).then((value) => context.go(Routes.listen)),
          //   ),
          //   itemCount: libraries.length,
          // ),
        ),
      ],
    );
  }

  Widget _titleText() => const Text(
        'Select Library',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
      );

  Widget _searchButton() => IconButton(
        onPressed: () {},
        icon: const Icon(JPlayer.search),
      );
}
