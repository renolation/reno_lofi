
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reno_music/data/library_entity.dart';

import '../../repositories/jellyfin_api.dart';
import '../../state/current_user_provider.dart';
import '../../state/secure_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_library_provider.g.dart';

@riverpod
class ListLibraryProvider extends _$ListLibraryProvider {

  late final JellyfinApi _api;
  late final String _userId;

  @override
  FutureOr<List<LibraryEntity>> build() async {
    _api = ref.read(jellyfinApiProvider);
    _userId = ref.read(currentUserProvider)!.userId;
    return fetchLibraries();
  }

  Future<List<LibraryEntity>> fetchLibraries() async {
    final libraries = await _api.getLibraries(userId: _userId);
    return libraries.libraries.where((element) => element.type == 'CollectionFolder' && element.collectionType == 'music').toList();
  }
}


@Riverpod(keepAlive: true)
class SelectingLibraryController extends _$SelectingLibraryController {

  late final FlutterSecureStorage _storage;
  final String libraryPathStorageKey = 'library_path';
  final String libraryIdStorageKey = 'library_id';

  @override
  LibraryEntity? build() {
    _storage = ref.read(secureStorageProvider);
    return null;
  }
  Future<void> setSelectLibrary(LibraryEntity lib) async {
    await _storage.write(key: libraryIdStorageKey, value: lib.id);
    await _storage.write(key: libraryPathStorageKey, value: lib.path);
    state = lib;
  }
}