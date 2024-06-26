import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:reno_music/features/player_screen/data/player_controller.dart';
import 'package:reno_music/features/player_screen/domain/audio_entity.dart';
import 'package:reno_music/providers/player_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reno_music/utils/functions.dart';

import '../../../utils/constants.dart';

class PlayerScreen extends HookConsumerWidget {
  const PlayerScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerProvider = ref.watch(playerControllerProvider);

    final playingAudio = useState(playerProvider[0]);
    final indexPlaying = useState(0);

    final playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: [
        for (var audio in playerProvider)
          AudioSource.uri(Uri.parse(audio.fileUrl!)),
      ],
    );

    log('rebuild');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 48,
            ),
            //region top bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: const Color(0xff212123),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                        child: FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                      size: 18,
                    )),
                  ),
                ),
                Text(
                  'Now Playing',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(),
                    );
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: const Color(0xff212123),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                        child: FaIcon(
                      FontAwesomeIcons.ellipsis,
                      color: Colors.white,
                      size: 18,
                    )),
                  ),
                ),
              ],
            ),
            //endregion
            Consumer(builder: (context, ref, child) {
              final audioProvider = ref.read(myAudioProvider);
              audioProvider.currentIndexStream.listen((event) {
                if (event != null) {
                  playingAudio.value = playerProvider[event];
                }
              });
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(48),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: CachedNetworkImage(
                            imageUrl: playingAudio.value.posterUrl!,
                            width: 240,
                            height: 240,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(playingAudio.value.title!,
                                  style: const TextStyle(fontSize: 18)),
                              AutoSizeText(
                                playingAudio.value.artist!,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: Colors.grey,
                                        letterSpacing: 1.2,
                                        fontSize: 14),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const FaIcon(FontAwesomeIcons.heart,
                              color: Colors.white, size: 18),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              showBarModalBottomSheet(
                                backgroundColor: Theme.of(context).colorScheme.background,
                                context: context,
                                useRootNavigator: true,
                                builder: (context) => ListView.builder(
                                    itemCount: playerProvider.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          playerProvider[index].title!,
                                        ),
                                        onTap: () {
                                          indexPlaying.value = index;
                                          playingAudio.value =
                                              playerProvider[index];
                                          ref.read(myAudioProvider).seek(
                                              const Duration(seconds: 0),
                                              index: index);
                                          Navigator.pop(context);
                                        },
                                      );
                                    }),
                              );
                            },
                            icon:
                                const FaIcon(FontAwesomeIcons.listUl, size: 18),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
            //region playing bar
            Expanded(
              child: Container(
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Consumer(builder: (context, ref, child) {
                  final audioProvider = ref.watch(myAudioProvider);
                  final currentPos = ref.watch(currentPosStream);
                  return currentPos.when(
                      data: (data) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SliderTheme(
                              data: SliderThemeData(
                                  overlayShape: SliderComponentShape.noThumb),
                              child: Slider(
                                value: data,
                                min: 0.0,
                                max: audioProvider.duration?.inSeconds
                                        .toDouble() ??
                                    100,
                                onChanged: (value) {
                                  log(value.toString());
                                  ref
                                      .read(myAudioProvider)
                                      .seek(Duration(seconds: value.toInt()));
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(formatTime(data.toInt())),
                                  audioProvider.duration?.inSeconds == null
                                      ? const Text('0:00')
                                      : Text(formatRemainingTime(
                                          audioProvider.duration!.inSeconds -
                                              data.toInt())),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      error: (err, stack) => Text('Error $err'),
                      loading: () => const Text('loading'));
                }),
              ),
            ),
            //endregion
            SizedBox(
              height: 70,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Consumer(builder: (context, ref, child) {
                    final isShuffle = ref.watch(isShuffleProvider);
                    return IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        if (isShuffle) {
                          ref.read(isShuffleProvider.notifier).state = false;
                          ref
                              .read(myAudioProvider)
                              .setShuffleModeEnabled(false);
                        } else {
                          ref.read(isShuffleProvider.notifier).state = true;
                          ref.read(myAudioProvider).setShuffleModeEnabled(true);
                        }
                      },
                      icon: FaIcon(FontAwesomeIcons.shuffle,
                          color: isShuffle ? Colors.blue : Colors.white,
                          size: 32),
                    );
                  }),
                  IconButton(
                    onPressed: () {
                      indexPlaying.value--;
                      playingAudio.value = playerProvider[indexPlaying.value];
                      ref.read(myAudioProvider).seekToPrevious();
                    },
                    icon: const FaIcon(FontAwesomeIcons.backwardStep,
                        color: Colors.white, size: 32),
                  ),
                  Consumer(builder: (context, ref, child) {
                    final audioProvider = ref.read(myAudioProvider);
                    final isPlaying = ref.watch(isPlayingProvider);
                    audioProvider.playerStateStream.listen((event) {
                      if (event ==
                          PlayerState(true, ProcessingState.completed)) {
                        log('done play');
                        ref.read(isPlayingProvider.notifier).state = false;
                      }
                    });
                    return InkWell(
                      onTap: () async {
                        print(playingAudio.value.fileUrl!);
                        if (isPlaying) {
                          ref.read(isPlayingProvider.notifier).state = false;
                          await audioProvider.pause();
                        } else {
                          ref.read(isPlayingProvider.notifier).state = true;
                          await audioProvider.setAudioSource(playlist,
                              initialIndex: 0, initialPosition: Duration.zero);
                          await audioProvider.play();
                        }
                      },
                      child: Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                          child: Center(
                              child: FaIcon(
                                  isPlaying
                                      ? FontAwesomeIcons.pause
                                      : FontAwesomeIcons.play,
                                  color: Colors.white,
                                  size: 48))),
                    );
                  }),
                  IconButton(
                    onPressed: () {
                      indexPlaying.value++;
                      playingAudio.value = playerProvider[indexPlaying.value];
                      ref.read(myAudioProvider).seekToNext();
                    },
                    icon: const FaIcon(FontAwesomeIcons.forwardStep,
                        color: Colors.white, size: 32),
                  ),
                  Consumer(builder: (context, ref, child) {
                    final loopMode = ref.watch(isLoopProvider);
                    return IconButton(
                      onPressed: () {
                        LoopMode loop = switch (loopMode) {
                          LoopMode.off => LoopMode.one,
                          LoopMode.one => LoopMode.all,
                          LoopMode.all => LoopMode.off,
                        };
                        ref.read(isLoopProvider.notifier).state = loop;
                        ref.read(myAudioProvider).setLoopMode(loop);
                      },
                      icon: FaIcon(FontAwesomeIcons.repeat,
                          color: loopMode == LoopMode.off
                              ? Colors.white
                              : loopMode == LoopMode.one
                                  ? Colors.grey
                                  : Colors.blue,
                          size: 32),
                    );
                  })
                ],
              ),
            ),

            const SizedBox(
              height: 0,
            ),
          ],
        ),
      ),
    );
  }
}
