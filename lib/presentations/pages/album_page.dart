import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reno_music/presentations/views/player_song_view.dart';
import 'package:reno_music/presentations/widgets/play_pause_button.dart';
import 'package:reno_music/state/auth_controller.dart';
import 'package:reno_music/state/custom_scrollbar.dart';
import 'package:reno_music/state/gradient_background.dart';
import 'package:reno_music/state/playback_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../domains/domains.dart';
import '../../repositories/jellyfin_api.dart';
import '../../state/base_url_provider.dart';
import '../../state/color_scheme_provider.dart';
import '../../state/current_user_provider.dart';
import '../../state/player_provider.dart';
import '../../utils/image_service.dart';

import 'dart:math';

import '../resources/resources.dart';
import '../widgets/play_button.dart';

// class AlbumPage extends ConsumerStatefulWidget {
//   const AlbumPage({super.key, required this.album});
//   final ItemEntity album;
//   @override
//   ConsumerState createState() => _AlbumPageState();
// }
//
// class _AlbumPageState extends ConsumerState<AlbumPage> {
//
//   List<SongsEntity> songs = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _getSongs();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Album: ${widget.widget.album.name}'),
//       ),
//       body: ListView.builder(
//         itemCount: songs.length,
//           itemBuilder: (context, index){
//             return InkWell(
//               onTap: () async {
//
//                 ref.read(playbackNotifierProvider.notifier).play(songs[index], songs, widget.album);
//               },
//                 child: SizedBox(
//                   height: 50,
//                   child: Column(
//                     children: [
//                       Text(songs[index].name!),
//                     ],
//                   ),
//                 ));
//           }
//       ),
//     );
//   }
//
//   void _getSongs() {
//     ref.read(jellyfinApiProvider).getSongs(userId: ref.read(currentUserProvider)!, albumId: widget.widget.album.id).then((value) {
//       setState(() {
//         final items = [...value.items]..sort((a, b) => a.indexNumber.compareTo(b.indexNumber));
//         songs = items;
//       });
//     });
//   }
// }

class AlbumPage extends StatefulHookConsumerWidget {
  const AlbumPage({super.key, required this.album});

  final ItemEntity album;

  @override
  ConsumerState createState() => _AlbumPageState();
}

class _AlbumPageState extends ConsumerState<AlbumPage> {
  final scrollController = ScrollController();
  final titleOpacity = ValueNotifier<double>(0);
  late ValueNotifier<MediaItem?> currentSong;
  final titleKey = GlobalKey(debugLabel: 'title');
  late final ImageService imageService;

  late ThemeData theme;
  late Size screenSize;
  late bool isMobile;
  late bool isDesktop;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentSong = ValueNotifier<MediaItem?>(null);

    imageService = ImageService(serverUrl: ref.read(baseUrlProvider.notifier).state!);
    scrollController.addListener(onScroll);
    createColorScheme();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    theme = Theme.of(context);
    screenSize = MediaQuery.sizeOf(context);
    final deviceType = getDeviceType(screenSize);
    isMobile = deviceType == DeviceScreenType.mobile;
    isDesktop = deviceType == DeviceScreenType.desktop;
  }

  void onScroll() {
    final titleContext = titleKey.currentContext;

    if (titleContext?.mounted ?? false) {
      final scrollPosition = scrollController.position;
      final scrollableContext = scrollPosition.context.notificationContext!;
      final scrollableRenderBox = scrollableContext.findRenderObject()! as RenderBox;
      final titleRenderBox = titleContext!.findRenderObject()! as RenderBox;
      final titlePosition = titleRenderBox.localToGlobal(
        Offset.zero,
        ancestor: scrollableRenderBox,
      );
      final titleHeight = titleContext.size!.height;
      final visibleFraction = (titlePosition.dy + titleHeight) / titleHeight;

      titleOpacity.value = 1 - min(max(visibleFraction, 0), 1);
    }
  }

  createColorScheme() {
    ref.read(playerProvider).sequenceStateStream.listen((event) {
      if (event != null) {
        if (mounted) {
          currentSong.value = event.sequence[event.currentIndex].tag as MediaItem;
          ref.read(imageSchemeProvider.notifier).state = imageService.albumIP(
            id: widget.album.id,
            tagId: widget.album.imageTags['Primary'],
          );
        }
      }
    });
  }

  Widget albumDetails({
    required Duration duration,
    required int soundsCount,
    int? year,
    String? albumArtist,
    Widget divider = const SizedBox.shrink(),
  }) {
    final durationInSeconds = duration.inSeconds;
    final hours = durationInSeconds ~/ Duration.secondsPerHour;
    final minutes = (durationInSeconds - hours * Duration.secondsPerHour) ~/ Duration.secondsPerMinute;
    final seconds = durationInSeconds % Duration.secondsPerMinute;

    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 6),
            child: Icon(JPlayer.clock, size: 14),
          ),
          Text(
            [
              if (hours > 0) hours.toString().padLeft(2, '0'),
              minutes.toString().padLeft(2, '0'),
              seconds.toString().padLeft(2, '0'),
            ].join(':'),
          ),
          divider,
          const Padding(
            padding: EdgeInsets.only(right: 6),
            child: Icon(JPlayer.music, size: 14),
          ),
          Text('$soundsCount songs'),
          if (year != null) ...[
            divider,
            Text(
              year.toString(),
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final songs = useState<List<SongsEntity>>([]);

    ImageProvider albumCover() => imageService.albumIP(id: widget.album.id, tagId: widget.album.imageTags['Primary']);
    void getSongs() {
      ref
          .read(jellyfinApiProvider)
          .getSongs(userId: ref.read(currentUserProvider)!, albumId: widget.album.id)
          .then((value) {
        final items = [...value.items]..sort((a, b) => a.indexNumber.compareTo(b.indexNumber));
        songs.value = items;
      });
    }

    useEffect(() {
      scrollController.addListener(onScroll);
      Future.microtask(() => getSongs());
      return null;
    }, []);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoNavigationBar(
                previousPageTitle: 'Albums',
                backgroundColor: Colors.transparent,
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: isMobile ? 16 : 30,
                ),
                middle: ValueListenableBuilder(
                  valueListenable: titleOpacity,
                  builder: (context, opacity, child) => Transform.translate(
                    offset: Offset(0, 8 - 8 * opacity),
                    child: Opacity(
                      opacity: opacity,
                      child: child,
                    ),
                  ),
                  child: Text(
                    widget.album.name,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 22,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: CustomScrollbar(
                controller: scrollController,
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    if (isDesktop)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image(
                                image: albumCover(),
                                height: 254,
                              ),
                              const SizedBox(width: 38),
                              Expanded(
                                  child: IconTheme(
                                data: theme.iconTheme.copyWith(size: isMobile ? 24 : 28),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                widget.album.name,
                                                key: titleKey,
                                                style: TextStyle(
                                                  fontSize: isMobile ? 18 : 32,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(widget.album.albumArtist ?? ''),
                                        Row(
                                          children: [
                                            albumDetails(
                                              duration: widget.album.duration,
                                              soundsCount: songs.value.length,
                                              albumArtist: songs.value.isNotEmpty ? songs.value.first.albumArtist : '',
                                              year: widget.album.productionYear,
                                              divider: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: Offstage(
                                                  offstage: isMobile,
                                                  child: const Icon(Icons.circle, size: 4),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                    SizedBox(width: isDesktop ? 35 : 32),
                                    if (isDesktop)
                                      const SizedBox()
                                    else
                                      Wrap(
                                        spacing: isMobile ? 6 : 32,
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(JPlayer.download),
                                          ),
                                          //todo: random queue button
                                          // const RandomQueueButton(),
                                          SizedBox.square(
                                            dimension: isMobile ? 40 : 48,
                                            child: PlayButton(
                                              onPressed: () {},
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                      )
                    else ...[
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 30,
                        ),
                        sliver: SliverPersistentHeader(
                          pinned: true,
                          delegate: _FadeOutImageDelegate(
                            image: albumCover(),
                            isMobile: isMobile,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(
                          left: isMobile ? 16 : 30,
                          top: isMobile ? 15 : 35,
                          right: isMobile ? 16 : 30,
                          bottom: isMobile ? 0 : 18,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: IconTheme(
                            data: theme.iconTheme.copyWith(size: isMobile ? 24 : 28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        widget.album.name,
                                        key: titleKey,
                                        style: TextStyle(
                                          fontSize: isMobile ? 18 : 32,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(widget.album.albumArtist ?? ''),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    albumDetails(
                                      duration: widget.album.duration,
                                      soundsCount: songs.value.length,
                                      albumArtist: songs.value.isNotEmpty ? songs.value.first.albumArtist : '',
                                      year: widget.album.productionYear,
                                      divider: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Offstage(
                                          offstage: isMobile,
                                          child: const Icon(Icons.circle, size: 4),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // _downloadAlbumButton(),
                                        //todo: random button
                                        // const RandomQueueButton(),
                                        SizedBox.square(
                                          dimension: isMobile ? 38 : 48,
                                          // child:PlayButton(
                                          //   onPressed: () {
                                          //     ref.read(playbackNotifierProvider.notifier).play(songs.value[0], songs.value, widget.album);
                                          //   },
                                          // ),
                                          child: Consumer(builder: (context, ref, child) {
                                            final playbackStatus =
                                                ref.watch(playbackNotifierProvider.select((value) => value.status));
                                            final stateNotifier =
                                                ValueNotifier<bool>(playbackStatus == PlaybackStatus.playing);
                                            return PlayPauseButton(
                                                onPressed: () => playbackStatus == PlaybackStatus.playing || playbackStatus == PlaybackStatus.paused
                                                    ? ref.read(playbackNotifierProvider.notifier).playPause()
                                                    : ref
                                                        .read(playbackNotifierProvider.notifier)
                                                        .play(songs.value[0], songs.value, widget.album),
                                                stateNotifier: stateNotifier);
                                          }),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    SliverList.builder(
                        itemCount: songs.value.length,
                        itemBuilder: (context, index) => ValueListenableBuilder(
                              valueListenable: currentSong,
                              builder: (context, item, other) {
                                SongsEntity song = songs.value[index];
                                return PlayerSongView(
                                  song: song, position: index + 1,
                                  isPlaying: item != null && song.id == item.id,
                                  onTap: () {
                                    ref.read(playbackNotifierProvider.notifier).play(song, songs.value, widget.album);
                                  },
                                  //todo: add favorite
                                );
                              },
                            )),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _FadeOutImageDelegate extends SliverPersistentHeaderDelegate {
  const _FadeOutImageDelegate({
    required this.image,
    required this.isMobile,
  });

  final ImageProvider image;
  final bool isMobile;

  @override
  double get maxExtent => isMobile ? 182 : 299;

  @override
  double get minExtent => 0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Image(
      image: image,
      height: max(maxExtent - shrinkOffset, 0),
      opacity: AlwaysStoppedAnimation(
        max((maxExtent - shrinkOffset * 1.5) / maxExtent, 0),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _FadeOutImageDelegate oldDelegate) =>
      image != oldDelegate.image || isMobile != oldDelegate.isMobile;
}
