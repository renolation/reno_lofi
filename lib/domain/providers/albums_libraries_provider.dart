import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reno_music/data/albums_entity.dart';
import 'package:reno_music/data/item_entity.dart';
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
  FutureOr<List<ItemEntity>> build(String libraryId) async {
    _api = ref.read(jellyfinApiProvider);
    _storage = ref.read(secureStorageProvider);
    _userId = ref.read(currentUserProvider)!.userId;
    return fetchAlbums(libraryId);
  }

  FutureOr<List<ItemEntity>> fetchAlbums(String libraryId) async  {
    final albums = await _api.getAlbums(userId: _userId, libraryId: libraryId);
    return albums.items;
  }


}