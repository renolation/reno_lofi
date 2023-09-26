
import 'package:dio/dio.dart';
import 'package:reno_music/features/home_screen/data/home_repository.dart';
import 'package:reno_music/features/player_screen/domain/audio_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

@Riverpod(keepAlive: true)
class HomeController extends _$HomeController {
    @override
  FutureOr<List<AudioEntity>> build() {
    return getHotAudio();
  }

  Future<List<AudioEntity>> getHotAudio(){
    final homeRepository = ref.watch(homeRepositoryProvider);
    final cancelToken = CancelToken();
    return homeRepository.getHotAudio(
      cancelToken: cancelToken,
    );
  }
}
