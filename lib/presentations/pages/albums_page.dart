import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reno_music/data/artists_libraries_provider.dart';
import 'package:reno_music/data/current_album_controller.dart';
import 'package:reno_music/presentations/views/albums_view.dart';
import 'package:reno_music/state/scrollable_page_scaffold.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../data/albums_libraries_provider.dart';
import '../../domains/domains.dart';
import '../../domains/filter.dart';
import '../../route/routes.dart';
import '../../utils/enums/entities.dart';
import '../../utils/enums/listen_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AlbumsPage extends HookConsumerWidget {
  const AlbumsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentView = useState<ListenView>(ListenView.values.first);
    final _appliedFilter = useState<Filter>(Filter(orderBy: EntityFilter.values.first));

    AlbumsEntity albumsEntity = const AlbumsEntity(items: [], totalRecordCount: 0);

    ThemeData _theme = Theme.of(context);
    Size _screenSize = MediaQuery.sizeOf(context);

    final deviceType = getDeviceType(_screenSize);
    bool _isMobile = deviceType == DeviceScreenType.mobile;
    bool _isTablet = deviceType == DeviceScreenType.tablet;

    Map<ListenView, String> _viewLabels = {
      ListenView.albums: 'Albums',
      ListenView.artists: 'Artists',
    };

    Map<EntityFilter, String> _filtersLabels = {
      EntityFilter.dateCreated: 'Date Added',
      EntityFilter.albumArtist: 'Album Artist',
      EntityFilter.sortName: 'Name',
    };

    return ScrollablePageScaffold(
      useGradientBackground: true,
      navigationBar: PreferredSize(
        preferredSize: Size.fromHeight(_isMobile ? 60 : 100),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _isMobile ? 16 : 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChipTheme(data: ChipTheme.of(context).copyWith(
                labelStyle: TextStyle(fontSize: _isMobile ? 14 : 16)
              ), child: Wrap(
                spacing: 12,
                children: [
                  for(final value in ListenView.values)
                    ValueListenableBuilder(valueListenable: _currentView, builder: (context, currentView, child){
                      return ActionChip(
                        label: Text(_viewLabels[value] ?? '???'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: (value == currentView) ? _theme.chipTheme.selectedColor : _theme.chipTheme.backgroundColor,
                        onPressed: (){
                          _currentView.value = value;
                        },
                      );
                    })
                ],
              )),
              TextButton(
                onPressed: () {
                  ref.read(albumsLibrariesProviderProvider.notifier).loadMore();
                },
                child: Text('Button'),
              ),
              TextButton(
                onPressed: () {
                  ref.read(artistsLibrariesProviderProvider.notifier).loadMore();
                },
                child: Text('Button'),
              ),
            ],
          ),
        ),
      ),
      contentPadding: EdgeInsets.only(
        left: _isMobile ? 16 : 30,
        right: _isMobile ? 16 : 30,
        bottom: 30,
      ),
      slivers: [
        ValueListenableBuilder(
            valueListenable: _currentView,
            builder: (context, value, child) {
              switch (value) {
                case ListenView.albums:
                  return Consumer(builder: (context, ref, child) {
                    final data = ref.watch(albumsLibrariesProviderProvider);
                    return data.when(
                      data: (data) {
                        return SliverGrid.builder(
                            itemCount: data.items.length,
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: _isTablet ? 360 : 200,
                              mainAxisSpacing: _isMobile ? 15 : 24,
                              crossAxisSpacing: _isMobile ? 8 : (_isTablet ? 56 : 28),
                              childAspectRatio: _isTablet ? 360 / 413 : 175 / 215.7,
                            ),
                            itemBuilder: (context, index) {
                              final ItemEntity item = data.items[index];
                              return AlbumsView(album: item,
                                onTap: (){
                                  final location = GoRouterState.of(context).fullPath;
                                  ref.read(currentAlbumControllerProvider.notifier).setAlbum(item);
                                  context.go('$location${Routes.album}', extra: {'album': item});
                                },
                              );
                              return InkWell(
                                  onTap: () {
                                    // context.goNamed('album');
                                    final location = GoRouterState.of(context).fullPath;
                                    // ref.read(currentAlbumProvider.notifier).setAlbum(album);
                                    context.go('$location/album', extra: {'album': item});
                                  },
                                  child: Text(item.name));
                            });
                      },
                      error: (error, stackTrace) => SliverToBoxAdapter(child: Text(error.toString())),
                      loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),

                    );
                  });
                case ListenView.artists:
                  return Consumer(builder: (context, ref, child) {
                    final data = ref.watch(artistsLibrariesProviderProvider);
                    return data.when(
                      data: (data) {
                        return SliverGrid.builder(
                            itemCount: data.items.length,
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: _isTablet ? 360 : 200,
                              mainAxisSpacing: _isMobile ? 15 : 24,
                              crossAxisSpacing: _isMobile ? 8 : (_isTablet ? 56 : 28),
                              childAspectRatio: _isTablet ? 360 / 413 : 175 / 215.7,
                            ),
                            itemBuilder: (context, index) {
                              final ItemEntity item = data.items[index];
                              return AlbumsView(album: item,
                                onTap: (){
                                  // final location = GoRouterState.of(context).fullPath;
                                  // ref.read(currentAlbumControllerProvider.notifier).setAlbum(item);
                                  // context.go('$location${Routes.album}', extra: {'album': item});
                                },
                              );
                              return InkWell(
                                  onTap: () {
                                    // context.goNamed('album');
                                    final location = GoRouterState.of(context).fullPath;
                                    // ref.read(currentAlbumProvider.notifier).setAlbum(album);
                                    context.go('$location/album', extra: {'album': item});
                                  },
                                  child: Text(item.name));
                            });
                      },
                      error: (error, stackTrace) => SliverToBoxAdapter(child: Text(error.toString())),
                      loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),

                    );
                  });
              }
            }),
      ],
    );
  }
}
