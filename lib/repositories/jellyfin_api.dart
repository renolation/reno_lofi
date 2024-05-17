import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/library_entity.dart';
import '../state/base_url_provider.dart';
import '../state/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'jellyfin_api.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class JellyfinApi {
  factory JellyfinApi(Dio client, {String baseUrl}) = _JellyfinApi;

  @GET('/Users/{userId}/Views')
  Future<Libraries> getLibraries({@Path('userId') required String userId});

}

Provider<JellyfinApi> jellyfinApiProvider = Provider<JellyfinApi>(
  (ref) => JellyfinApi(
    ref.watch(dioProvider),
    baseUrl: ref.watch(baseUrlProvider) ?? 'https://music.renolation.com',
  ),
);
