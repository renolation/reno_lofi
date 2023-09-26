import 'package:dio/dio.dart';
import 'package:reno_music/features/player_screen/domain/audio_entity.dart';
import 'package:reno_music/features/player_screen/domain/playlist_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


import '../../../providers/dio_provider.dart';
import '../../../utils/constants.dart';

part 'home_repository.g.dart';


class HomeRepository {
  HomeRepository({required this.client});

  final Dio client;

  Future<List<AudioEntity>> getHotAudio({CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: Constants.scheme,
      host: Constants.host,
      port: Constants.port,
      path: 'audio',
    ).toString();
    print(url);
    final response = await client.get(url, cancelToken: cancelToken);
    final List list = response.data;
    return list.map((e) => AudioEntity.fromJson(e)).toList();
  }

    Future<List<PlaylistEntity>> getHomePlaylist({CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: Constants.scheme,
      host: Constants.host,
      port: Constants.port,
      path: 'playlist',
    ).toString();
    print(url);
    final response = await client.get(url, cancelToken: cancelToken);
    final List list = response.data;
    return list.map((e) => PlaylistEntity.fromJson(e)).toList();
  }

}

@Riverpod(keepAlive: true)
HomeRepository homeRepository(HomeRepositoryRef ref) => HomeRepository(
      client: ref.watch(dioProvider),
    );