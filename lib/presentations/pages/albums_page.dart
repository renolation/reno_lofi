import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reno_music/data/artists_libraries_provider.dart';
import 'package:reno_music/data/current_album_controller.dart';
import 'package:reno_music/presentations/views/albums_view.dart';
import 'package:reno_music/state/filter_notifier.dart';
import 'package:reno_music/state/scrollable_page_scaffold.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../data/albums_libraries_provider.dart';
import '../../domains/domains.dart';
import '../../domains/filter.dart';
import '../../route/routes.dart';
import '../../utils/enums/entities.dart';
import '../../utils/enums/listen_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../resources/resources.dart';

class AlbumsPage extends HookConsumerWidget {
  const AlbumsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentView = useState<ListenView>(ListenView.values.first);
    final _appliedFilter = useState<Filter>(Filter(orderBy: EntityFilter.values.first));
    final _filterOpened = ValueNotifier<bool>(false);

    AlbumsEntity albumsEntity = const AlbumsEntity(items: [], totalRecordCount: 0);

    ThemeData theme = Theme.of(context);
    Size screenSize = MediaQuery.sizeOf(context);

    final deviceType = getDeviceType(screenSize);
    bool _isMobile = deviceType == DeviceScreenType.mobile;
    bool _isTablet = deviceType == DeviceScreenType.tablet;

    Map<ListenView, String> viewLabels = {
      ListenView.albums: 'Albums',
      ListenView.artists: 'Artists',
    };

    Map<EntityFilter, String> filtersLabels = {
      EntityFilter.dateCreated: 'Date Added',
      EntityFilter.albumArtist: 'Album Artist',
      EntityFilter.sortName: 'Name',
    };

    List<EntityFilter> getFilterItems() {
      switch (_currentView.value) {
        case ListenView.albums:
          return EntityFilter.values.toList();
        case ListenView.artists:
          return [EntityFilter.sortName];
      }
    }

    void applyFilter(EntityFilter? value) {
      final filter = ref.read(filterProvider);
      if (filter.orderBy == value) {
        final desc = !filter.desc;
        ref.read(filterProvider.notifier).filter(value!, desc);
      } else {
        ref.read(filterProvider.notifier).filter(value!, false);
      }
    }

    String filterLabel(EntityFilter filter) {
      return filtersLabels[filter] ?? '???';
    }

    List<ItemEntity> reorder(List<ItemEntity> list, Filter filter){
      List<ItemEntity> items = [...list];
      switch(filter){
        case Filter(orderBy: EntityFilter.sortName, desc: true):
          items.sort((a, b) => a.name.compareTo(b.name));
          break;
        case Filter(orderBy: EntityFilter.albumArtist, desc: true):
          items.sort((a, b) => a.albumArtist!.compareTo(b.albumArtist!));
          break;
        case Filter(orderBy: EntityFilter.dateCreated, desc: true):
          items.sort((a, b) => a.productionYear!.compareTo(b.productionYear!));
          break;
        case Filter(orderBy: EntityFilter.sortName, desc: false):
          items.sort((a, b) => b.name.compareTo(a.name));
          break;
        case Filter(orderBy: EntityFilter.albumArtist, desc: false):
          items.sort((a, b) => b.albumArtist!.compareTo(a.albumArtist!));
          break;
        case Filter(orderBy: EntityFilter.dateCreated, desc: false):
          items.sort((a, b) => b.productionYear!.compareTo(a.productionYear!));
          break;
      }
      return items;
    }

    Future<void> loadMore()async {
      //todo: add check empty result and block call new
      await switch(_currentView.value){
        ListenView.albums =>  ref.read(albumsLibrariesProviderProvider.notifier).loadMore(),
        ListenView.artists =>  ref.read(albumsLibrariesProviderProvider.notifier).loadMore(),
      };

    }

    return ScrollablePageScaffold(
      useGradientBackground: true,
      navigationBar: PreferredSize(
        preferredSize: Size.fromHeight(_isMobile ? 60 : 100),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _isMobile ? 16 : 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChipTheme(
                  data: ChipTheme.of(context).copyWith(labelStyle: TextStyle(fontSize: _isMobile ? 14 : 16)),
                  child: Wrap(
                    spacing: 12,
                    children: [
                      for (final value in ListenView.values)
                        ValueListenableBuilder(
                            valueListenable: _currentView,
                            builder: (context, currentView, child) {
                              return ActionChip(
                                label: Text(viewLabels[value] ?? '???'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: (value == currentView)
                                    ? theme.chipTheme.selectedColor
                                    : theme.chipTheme.backgroundColor,
                                onPressed: () {
                                  _currentView.value = value;
                                  applyFilter(_currentView.value == ListenView.albums
                                      ? EntityFilter.dateCreated
                                      : EntityFilter.sortName);
                                  _appliedFilter.value = Filter(
                                      orderBy: _currentView.value == ListenView.albums
                                          ? EntityFilter.dateCreated
                                          : EntityFilter.sortName,
                                      desc: true);
                                },
                              );
                            })
                    ],
                  )),
              DropdownButtonHideUnderline(
                  child: ValueListenableBuilder(
                valueListenable: _currentView,
                builder: (context, view, widget) {
                  final filter = ref.watch(filterProvider);
                  return DropdownButton2<EntityFilter>(
                    customButton: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ValueListenableBuilder(
                        valueListenable: _filterOpened,
                        builder: (context, isOpened, child) => Icon(
                          JPlayer.sliders,
                          color: isOpened ? theme.colorScheme.primary : theme.iconTheme.color,
                        ),
                      ),
                    ),
                    buttonStyleData: const ButtonStyleData(
                      overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      width: 150,
                      padding: const EdgeInsets.all(8),
                      offset: const Offset(0, -8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    items: [
                      for (final value in getFilterItems())
                        DropdownMenuItem(
                          value: value,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  filterLabel(value),
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.2,
                                    color: (filter.orderBy == value)
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                              Icon(
                                filter.desc ? Icons.arrow_upward : Icons.arrow_downward,
                                color:
                                    (filter.orderBy == value) ? theme.colorScheme.primary : theme.colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        )
                    ],
                    value: filter.orderBy,
                    onChanged: applyFilter,
                    onMenuStateChange: (value) => _filterOpened.value = value,
                  );
                },
              )),
            ],
          ),
        ),
      ),
      contentPadding: EdgeInsets.only(
        left: _isMobile ? 16 : 30,
        right: _isMobile ? 16 : 30,
        bottom: 30,
      ),
      loadMoreData: loadMore,
      slivers: [
        ValueListenableBuilder(
            valueListenable: _currentView,
            builder: (context, value, child) {
              switch (value) {
                case ListenView.albums:
                  return Consumer(builder: (context, ref, child) {
                    final data = ref.watch(albumsLibrariesProviderProvider);
                    final filter = ref.watch(filterProvider);
                    print(filter.toString());
                    return data.when(
                      data: (data) {
                        List<ItemEntity> items = reorder(data.items,filter);
                        return SliverGrid.builder(
                            itemCount: items.length,
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: _isTablet ? 360 : 200,
                              mainAxisSpacing: _isMobile ? 15 : 24,
                              crossAxisSpacing: _isMobile ? 8 : (_isTablet ? 56 : 28),
                              childAspectRatio: _isTablet ? 360 / 413 : 175 / 215.7,
                            ),
                            itemBuilder: (context, index) {
                              final ItemEntity item = items[index];
                              return AlbumsView(
                                album: item,
                                onTap: () {
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
                    final filter = ref.watch(filterProvider);
                    return data.when(
                      data: (data) {
                        List<ItemEntity> items = reorder(data.items,filter);

                        return SliverGrid.builder(
                            itemCount: items.length,
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: _isTablet ? 360 : 200,
                              mainAxisSpacing: _isMobile ? 15 : 24,
                              crossAxisSpacing: _isMobile ? 8 : (_isTablet ? 56 : 28),
                              childAspectRatio: _isTablet ? 360 / 413 : 175 / 215.7,
                            ),
                            itemBuilder: (context, index) {
                              final ItemEntity item = items[index];
                              return AlbumsView(
                                album: item,
                                onTap: () {
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
