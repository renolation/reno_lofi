import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:reno_music/features/home_screen/data/hot_controller.dart';
import 'package:reno_music/features/home_screen/data/playlist_controller.dart';
import 'package:reno_music/features/player_screen/domain/audio_entity.dart';
import 'package:reno_music/features/player_screen/domain/playlist_entity.dart';
import 'package:reno_music/providers/player_provider.dart';
import 'package:reno_music/utils/app_router.dart';
import 'package:reno_music/utils/constants.dart';

import '../../player_screen/data/player_controller.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 48,
            ),
            //region top bar
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: const Color(0xff212123),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                      child: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.white,
                    size: 18,
                  )),
                ),
                const Spacer(),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: const Color(0xff212123),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                      child: FaIcon(
                    FontAwesomeIcons.bell,
                    color: Colors.white,
                    size: 18,
                  )),
                ),
                const SizedBox(
                  width: 24,
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: const Color(0xff212123),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                      child: FaIcon(
                    FontAwesomeIcons.gear,
                    color: Colors.white,
                    size: 18,
                  )),
                ),
              ],
            ),
            //endregion
            const SizedBox(
              height: 32,
            ),
            InkWell(
              onTap: () {
                ref.read(playerControllerProvider.notifier).addAdd(listAudio);
                context.pushNamed(AppRoute.player.name, extra: listAudio);
              },
              child: Text(
                'Browse',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            // SizedBox(
            //   height: 30,
            // child: ListView(
            //   shrinkWrap: true,
            //   scrollDirection: Axis.horizontal,
            //   children: [
            //     for (var text in listTab)
            //       Padding(
            //         padding: const EdgeInsets.only(right: 8),
            //         child: Text(
            //           text,
            //           style: Theme.of(context).textTheme.titleMedium,
            //         ),
            //       )
            //   ],
            // ),
            // ),
            Text(
              'Popular Playlist',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 200,
              child: Consumer(builder: (context, ref, child) {
                final playlistHome = ref.watch(playlistControllerProvider);
                return playlistHome.when(
                  data: (data) {
                    return ListView.builder(
                        itemCount: data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          PlaylistEntity playlistEntity = data[index];
                          return InkWell(
                            onTap: () {
                              //aaa
                              ref
                                  .read(playerControllerProvider.notifier)
                                  .addAdd(playlistEntity.songs!);

                              context.pushNamed(AppRoute.player.name,
                                  extra: playlistEntity.songs);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                        imageUrl: playlistEntity.poster!,
                                        width: 130,
                                        height: 130,
                                        fit: BoxFit.cover),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    playlistEntity.title!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontSize: 18),
                                  ),
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
                            ),
                          );
                        });
                  },
                  error: (err, stack) => Text('Error $err'),
                  loading: () => Text('loading'),
                );
              }),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Top hit 2023',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            Expanded(child: Consumer(builder: (context, ref, child) {
              final listHotAudio = ref.watch(hotControllerProvider);
              return listHotAudio.when(
                data: (data) {
                  return ListView.builder(
                      padding: const EdgeInsets.only(top: 16),
                      itemCount: data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        AudioEntity audioEntity = data[index];
                        return InkWell(
                          onTap: () {
                            ref.read(playerControllerProvider.notifier).addAdd([audioEntity]);


                            ref.read(isShuffleProvider.notifier).state = false;
                            ref
                                .read(myAudioProvider)
                                .setShuffleModeEnabled(false);
                            ref.read(isLoopProvider.notifier).state =
                                LoopMode.one;
                            context.pushNamed(AppRoute.player.name,
                                extra: [audioEntity]);
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.only(right: 16, bottom: 16),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                      imageUrl: audioEntity.posterUrl!,
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                SizedBox(
                                  height: 90,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        audioEntity.title!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(fontSize: 18),
                                      ),
                                      AutoSizeText(
                                        audioEntity.artist!,
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
                                ),
                                const Spacer(),
                                const FaIcon(FontAwesomeIcons.ellipsisVertical,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        );
                      });
                },
                error: (err, stack) => Text('Error $err'),
                loading: () => Text('loading'),
              );
            })),
          ],
        ),
      ),
    );
  }
}
