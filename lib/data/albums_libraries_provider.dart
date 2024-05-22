import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domains/item_entity.dart';
import '../repositories/jellyfin_api.dart';
import '../state/current_user_provider.dart';
import '../state/dio_provider.dart';
import '../state/secure_storage_provider.dart';
import 'list_library_provider.dart';

part 'albums_libraries_provider.g.dart';

@Riverpod(keepAlive: true)
class AlbumsLibrariesProvider  extends _$AlbumsLibrariesProvider{

  @override
  FutureOr<AlbumsState> build() async {
    return fetchAlbums();
  }

  FutureOr<AlbumsState> fetchAlbums() async  {
    final albums = await ref.read(jellyfinApiProvider).getAlbums(userId: ref.read(currentUserProvider)!, libraryId: ref.read(selectingLibraryControllerProvider)!.id, startIndex: '0');
    return AlbumsState(items: albums.items, currentPage: 1);
  }

  Future<void> loadMore() async {
    AlbumsState albumsState = state.value!;
    final albums = await ref.read(jellyfinApiProvider).getAlbums(userId: ref.read(currentUserProvider)!, libraryId: ref.read(selectingLibraryControllerProvider)!.id, startIndex: '${(albumsState.currentPage * limitPerCall)}');
    if(albums.items.isEmpty) return;
    state = AsyncData(albumsState.copyWith(items: [...albumsState.items, ...albums.items], currentPage:  albumsState.currentPage + 1));
  }
}


class AlbumsState {
  AlbumsState({this.items = const [], this.currentPage = 0,});

  List<ItemEntity> items;
  int currentPage = 0;

  AlbumsState copyWith({List<ItemEntity> items = const [], int currentPage = 0,}) {
    return AlbumsState(items: items, currentPage: currentPage);
  }
}
