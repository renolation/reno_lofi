import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:reno_music/providers/player_provider.dart';

import '../../../utils/constants.dart';

class PlayerScreen extends HookConsumerWidget {
  const PlayerScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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
                Container(
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
                Text(
                  'Now Playing',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Container(
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
              ],
            ),
            //endregion
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(48),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: CachedNetworkImage(
                          imageUrl:
                              'https://b2.renolation.com/file/music-reno/kristaps-ungurs-hqXqJ5QTeQQ-unsplash.jpg',
                          width: 240,
                          height: 240,
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Kristaps Ungurs',
                                style: TextStyle(fontSize: 18)),
                            AutoSizeText(
                              'Tyler the creator',
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
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 80,
                child: Consumer(builder: (context, ref, child) {
                  final audioProvider = ref.watch(myAudioProvider);
                  final currentPos = ref.watch(currentPosStream);
                 return currentPos.when(data: (data){
                   return Slider(
                     value:data,
                     min: 0.0,
                     max: audioProvider.duration?.inSeconds.toDouble() ?? 100,
                     onChanged: (value) {
                       log(value as String);
                       ref.read(myAudioProvider).seek(Duration(seconds: value.toInt()));
                     },
                   );
                  }, error: (err, stack)
                  =>
                      Text('Error $err')
                  ,
                  loading: () =>
                  const Text('loading')
                  );

                }),
              ),
            ),


            SizedBox(
              height: 70,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const FaIcon(FontAwesomeIcons.shuffle,
                      color: Colors.white, size: 32),
                  const FaIcon(FontAwesomeIcons.backwardStep,
                      color: Colors.white, size: 32),
                  Consumer(builder: (context, ref, child) {
                    final audioProvider = ref.read(myAudioProvider);
                    final isPlaying = ref.watch(isPlayingProvider);
                    audioProvider.playerStateStream.listen((event) {
                      if(event == PlayerState(true, ProcessingState.completed)){
                        log('done play');
                        ref.read(isPlayingProvider.notifier).state = false;

                      }
                    });
                    return  InkWell(
                      onTap: () async {
                        if(isPlaying){
                          ref.read(isPlayingProvider.notifier).state = false;

                          await audioProvider.pause();
                        } else {
                          ref.read(isPlayingProvider.notifier).state = true;
                          await audioProvider.setUrl(urlMp3);
                          // await audioProvider.seek(const Duration(seconds: 110));
                          await audioProvider.play();
                        }
                      },
                      child: Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                          child: Center(
                              child: FaIcon(isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                                  color: Colors.white, size: 48))),
                    );
                  }),
                  const FaIcon(FontAwesomeIcons.forwardStep,
                      color: Colors.white, size: 32),
                  const FaIcon(FontAwesomeIcons.repeat,
                      color: Colors.white, size: 32),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}