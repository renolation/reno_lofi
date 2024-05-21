import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:reno_music/domains/domains.dart';
import 'package:reno_music/state/auth_controller.dart';
import 'package:reno_music/state/base_url_provider.dart';
import 'package:reno_music/state/player_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'current_user_provider.dart';

part 'playback_provider.g.dart';

enum PlaybackStatus { stopped, paused, playing, buffering, error }

class PlaybackState {
  PlaybackState({
    required this.status,
    required this.position,
    required this.cacheProgress,
    this.totalDuration,
  });

  final PlaybackStatus status;
  final Duration position;
  final Duration cacheProgress;
  final Duration? totalDuration;
}

@Riverpod(keepAlive: true)
class PlaybackNotifier extends _$PlaybackNotifier {
  late final AudioPlayer _audioPlayer;

  @override
  PlaybackState build() {
    _audioPlayer = ref.read(playerProvider);
    _audioPlayer.positionStream.listen((position) {
      state = PlaybackState(
        status: state.status,
        position: position,
        cacheProgress: state.cacheProgress,
        totalDuration: _audioPlayer.duration,
      );
    });
    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        state = PlaybackState(
            status: PlaybackStatus.stopped,
            position: Duration.zero,
            cacheProgress: Duration.zero,
            totalDuration: Duration.zero);
        print(_audioPlayer.sequenceState?.currentIndex);
        print('PlayerState: Completed');
        _audioPlayer.stop();
        _audioPlayer.setAudioSource(_audioPlayer.audioSource!, initialIndex: 0);
      }
      // Handle other player states as needed
    });
    return PlaybackState(status: PlaybackStatus.stopped, position: Duration.zero, cacheProgress: Duration.zero);
  }

  Future<void> play(SongsEntity songEntity, List<SongsEntity> listSong, ItemEntity album) async {
    try {
      final domainUri = Uri.parse(ref.read(baseUrlProvider)!);

      final playlist = ConcatenatingAudioSource(children: [
        for (final song in listSong)
          AudioSource.uri(Uri(
            scheme: domainUri.scheme,
            host: domainUri.host,
            port: domainUri.port,
            path: 'Audio/${song.id}/universal',
            queryParameters: {
              'UserId': ref.read(currentUserProvider)!,
              // 'api_key': ref.read(currentUserProvider)!.token,
              'DeviceId': '12345',
              'TranscodingProtocol': 'http',
              'TranscodingContainer': 'm4a',
              'AudioCodec': 'm4a',
              'Container': 'mp3,aac,m4a|aac,m4b|aac,flac,alac,m4a|alac,m4b|alac,wav,m4a,aiff,aif',
            },
          ),tag: MediaItem(
            id: song.id,
            album: song.albumName,
            artist: album.albumArtist,
            duration: Duration(milliseconds: (song.runTimeTicks / 10000).ceil()),
            title: song.name ?? 'Untitled',
            artUri:
            song.imageTags['Primary'] != null
                ? Uri.parse(ref.read(imageProvider).imagePath(tagId: song.imageTags['Primary']!, id: song.id))
                : album.imageTags['Primary'] != null
                ? Uri.parse(ref.read(imageProvider).imagePath(tagId: album.imageTags['Primary']!, id: album.id))
                : null,
          ),),

      ]);
      await _audioPlayer.setAudioSource(playlist, initialIndex: listSong.indexOf(songEntity), preload: false);
      unawaited(_audioPlayer.play());
      state = PlaybackState(
        status: PlaybackStatus.playing,
        position: Duration.zero,
        totalDuration: _audioPlayer.duration,
        cacheProgress: state.cacheProgress,
      );
    } catch (e) {
      if (e.toString().indexOf('setPitch') > 0) {
        // This is hack to avoid playback state being error on ios. This error always throws
        return;
      }
      state = PlaybackState(
        status: PlaybackStatus.error,
        position: Duration.zero,
        cacheProgress: state.cacheProgress,
      );
    }
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
    state = PlaybackState(
      status: state.status,
      position: position,
      cacheProgress: state.cacheProgress,
      totalDuration: state.totalDuration,
    );
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    state = PlaybackState(
      status: PlaybackStatus.paused,
      position: _audioPlayer.position,
      totalDuration: state.totalDuration,
      cacheProgress: state.cacheProgress,
    );
  }

  Future<void> playPause() async {
    if (state.status == PlaybackStatus.playing) {
      await pause();
    } else {
      await resume();
    }
  }

  // TODO: audio queue
  Future<void> resume() async {
    // if ((state.status == PlaybackStatus.stopped) && state.totalDuration?.inSeconds == 0) {
    //   final queue = ref.read(audioQueueProvider.notifier);
    //   // Case when song has finished but user clicks on play(resume) button. In this case we want to restart playback from first song.
    //   if (queue.state.songs.isNotEmpty) {
    //     await play(queue.state.songs.first, queue.state.songs, queue.state.album!);
    //   }
    //
    //   return;
    // }

    // }
    unawaited(_audioPlayer.play());
    state = PlaybackState(
      status: PlaybackStatus.playing,
      position: _audioPlayer.position,
      totalDuration: state.totalDuration,
      cacheProgress: state.cacheProgress,
    );
  }

  Future<void> next() async {
    return _audioPlayer.seekToNext();
    // await play(_ref.read(audioQueueProvider.notifier).nextSong, _ref.read(audioQueueProvider).songs, _ref.read(audioQueueProvider).album!);
  }

  Future<void> prev() async {
    return _audioPlayer.seekToPrevious();
    // await play(_ref.read(audioQueueProvider.notifier).prevSong, _ref.read(audioQueueProvider).songs, _ref.read(audioQueueProvider).album!);
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    state = PlaybackState(
      status: PlaybackStatus.stopped,
      position: Duration.zero,
      totalDuration: Duration.zero,
      cacheProgress: state.cacheProgress,
    );
  }

  void toggleRepeat() {
    state = PlaybackState(
      status: state.status,
      position: state.position,
      totalDuration: state.totalDuration,
      cacheProgress: state.cacheProgress,
    );
  }
}
