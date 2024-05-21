import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reno_music/domains/domains.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/jellyfin_api.dart';
part 'current_album_controller.g.dart';


@riverpod
class CurrentAlbumController extends _$CurrentAlbumController {

  late final JellyfinApi _api;
  final String libraryIdStorageKey = 'library_id';
  final String libraryPathStorageKey = 'library_path';
  late final FlutterSecureStorage _storage;

  @override
  ItemEntity? build(){
    _api = ref.read(jellyfinApiProvider);
    return null;
  }

  void setAlbum(ItemEntity album) {
    state = album;
  }
}