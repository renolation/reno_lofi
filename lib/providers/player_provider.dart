
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'player_provider.g.dart';

@Riverpod(keepAlive: true)
AudioPlayer myAudio(MyAudioRef ref) {
  return AudioPlayer();
}

final isPlayingProvider = StateProvider<bool>((ref) => false);
