import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

final playerProvider = Provider<AudioPlayer>((ref) {
  return AudioPlayer();
});

final playPauseProvider = StateProvider<ValueNotifier<bool>>((ref) {
  return ValueNotifier<bool>(false);
});