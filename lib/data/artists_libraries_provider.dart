import 'package:riverpod_annotation/riverpod_annotation.dart';


import '../domains/domains.dart';
import '../repositories/jellyfin_api.dart';
import '../state/current_user_provider.dart';
import '../state/dio_provider.dart';
import 'list_library_provider.dart';

part 'artists_libraries_provider.g.dart';

@Riverpod(keepAlive: true)
class ArtistsLibrariesProvider extends _$ArtistsLibrariesProvider{

  @override
  FutureOr<ArtistState> build() async {
    return fetchAlbums();
  }

  FutureOr<ArtistState> fetchAlbums() async  {
    final albums = await ref.read(jellyfinApiProvider).getArtists(userId: ref.read(currentUserProvider)!, startIndex: '0',);
    return ArtistState(items: albums.items, currentPage: 1);
  }

  Future<void> loadMore() async {
    ArtistState artistState = state.value!;
    final albums = await ref.read(jellyfinApiProvider).getArtists(userId: ref.read(currentUserProvider)!, startIndex: '${(artistState.currentPage * limitPerCall)}');
    state = AsyncData(artistState.copyWith(items: [...artistState.items, ...albums.items], currentPage:  artistState.currentPage + 1));
  }

}


class ArtistState {
  ArtistState({this.items = const [], this.currentPage = 0,});

  List<ItemEntity> items;
  int currentPage = 0;

  ArtistState copyWith({List<ItemEntity> items = const [], int currentPage = 0,}) {
    return ArtistState(items: items, currentPage: currentPage);
  }
}
