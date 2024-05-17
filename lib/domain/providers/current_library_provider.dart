
import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reno_music/data/library_entity.dart';

import '../../repositories/jellyfin_api.dart';
import '../../state/current_user_provider.dart';
import '../../state/secure_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_library_provider.g.dart';

@riverpod
class CurrentLibraryProvider extends _$CurrentLibraryProvider {

  late final JellyfinApi _api;
  late final FlutterSecureStorage _storage;
  final String libraryIdStorageKey = 'library_id';
  late final String _userId;
  final String libraryPathStorageKey = 'library_path';

  @override
  FutureOr<List<LibraryEntity>> build() async {
    _api = ref.read(jellyfinApiProvider);
    _storage = ref.read(secureStorageProvider);
    _userId = ref.read(currentUserProvider)!.userId;
    return fetchLibraries();
  }

  Future<List<LibraryEntity>> fetchLibraries() async {
    final libraries = await _api.getLibraries(userId: _userId);
    return libraries.libraries.where((element) => element.type == 'CollectionFolder' && element.collectionType == 'music').toList();
  }
}