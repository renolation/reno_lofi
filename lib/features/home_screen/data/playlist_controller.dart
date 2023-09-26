
import 'package:dio/dio.dart';
import 'package:reno_music/features/home_screen/data/home_repository.dart';
import 'package:reno_music/features/player_screen/domain/audio_entity.dart';
import 'package:reno_music/features/player_screen/domain/playlist_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'playlist_controller.g.dart';

@Riverpod(keepAlive: true)
class PlaylistController extends _$PlaylistController {
    @override
  FutureOr<List<PlaylistEntity>> build() {
    return getHomePlaylist();
  }

  Future<List<PlaylistEntity>> getHomePlaylist(){
    final homeRepository = ref.watch(homeRepositoryProvider);
    final cancelToken = CancelToken();
    return homeRepository.getHomePlaylist(
      cancelToken: cancelToken,
    );
  }
}
