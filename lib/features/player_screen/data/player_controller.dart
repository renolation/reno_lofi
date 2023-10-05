import 'package:reno_music/features/player_screen/domain/audio_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_controller.g.dart';

@Riverpod(keepAlive: true)
class PlayerController extends _$PlayerController {
  @override
  List<AudioEntity> build() {
    return [];
  }
  void addAdd(List<AudioEntity> list){
    state = list;
  }
}