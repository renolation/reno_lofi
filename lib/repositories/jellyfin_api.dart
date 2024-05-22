import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domains/domains.dart';
import '../state/base_url_provider.dart';
import '../state/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'jellyfin_api.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class JellyfinApi {
  factory JellyfinApi(Dio client, {String baseUrl}) = _JellyfinApi;

  //get collection
  @GET('/Users/{userId}/Views')
  Future<Libraries> getLibraries({@Path('userId') required String userId});

  //get Albums
  @GET('/Users/{userId}/Items')
  Future<AlbumsEntity> getAlbums({
    @Path('userId') required String userId,
    @Query('ParentId') required String libraryId,
    @Query('IncludeItemTypes') String type = 'MusicAlbum',
    @Query('StartIndex') String startIndex = '0',
    @Query('Limit') String limit = '$limitPerCall',
    @Query('SortBy') String sortBy = 'DateCreated,SortName',
    @Query('ContributingArtistIds') String? contributingArtistIds,
    @Query('SortOrder') String sortOrder = 'Descending',
    @Query('AlbumArtistIds') List<String> artistIds = const [],
    @Query('Recursive') bool recursive = true,
  });

  @GET('/Users/{userId}/Items')
  Future<SongsWrapper> getSongs(
      {@Path('userId') required String userId,
      @Query('ParentId') required String albumId,
      @Query('IncludeItemTypes') String includeType = 'music'});

  @GET('/Artists')
  Future<AlbumsEntity> getArtists({
    @Query('userId') required String userId,
    @Query('Fields') List<String> fields = const ['BackdropImageTags', 'Overview'],
    @Query('IncludeArtists') bool includeArtists = true,
    @Query('IncludeItemTypes') String type = 'Artist',
    @Query('StartIndex') String startIndex = '0',
    @Query('Limit') String limit = '$limitPerCall',
    @Query('SortBy') String sortBy = 'SortName',
    @Query('SortOrder') String sortOrder = 'Descending',
    @Query('Recursive') bool recursive = true,
  });

}

Provider<JellyfinApi> jellyfinApiProvider = Provider<JellyfinApi>(
  (ref) => JellyfinApi(
    ref.watch(dioProvider),
    baseUrl: ref.watch(baseUrlProvider)!,
  ),
);
