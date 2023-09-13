
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'player_provider.g.dart';

@Riverpod(keepAlive: true)
AudioPlayer myAudio(MyAudioRef ref) {
  return AudioPlayer();
}

final isPlayingProvider = StateProvider<bool>((ref) => false);
final isShuffleProvider = StateProvider<bool>((ref) => false);
final isLoopProvider = StateProvider<LoopMode>((ref) => LoopMode.off);

final currentPosStream = StreamProvider<double>((ref) {
  final audioPlayer = ref.watch(myAudioProvider);
  return audioPlayer.positionStream.map((position) => position.inSeconds.toDouble());
});
