import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reno_music/data/albums_entity.dart';
import 'package:reno_music/data/item_entity.dart';
import 'package:reno_music/domain/providers/list_library_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/jellyfin_api.dart';
import '../../state/current_user_provider.dart';
import '../../state/secure_storage_provider.dart';

part 'albums_libraries_provider.g.dart';

@riverpod
class AlbumsLibrariesProvider  extends _$AlbumsLibrariesProvider{

  late final JellyfinApi _api;
  late final FlutterSecureStorage _storage;
  late final String _userId;

  @override
  FutureOr<List<ItemEntity>> build() async {
    _api = ref.read(jellyfinApiProvider);
    _storage = ref.read(secureStorageProvider);
    _userId = ref.read(currentUserProvider)!.userId;
    return fetchAlbums();
  }

  FutureOr<List<ItemEntity>> fetchAlbums() async  {
    final libId = ref.read(selectingLibraryControllerProvider)!.id;
    final albums = await _api.getAlbums(userId: _userId, libraryId: libId);
    return albums.items;
  }


}