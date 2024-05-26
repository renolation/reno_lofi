import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:reno_music/domains/domains.dart';
import 'package:reno_music/presentations/widgets/simple_list_tile.dart';
import 'package:reno_music/state/playback_provider.dart';
import 'package:reno_music/state/player_provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../data/current_album_controller.dart';
import '../../state/queue_provider.dart';
import '../resources/resources.dart';
import 'play_pause_button.dart';
import 'position_slider.dart';

class BottomPlayer extends ConsumerStatefulWidget {
  const BottomPlayer({super.key});

  @override
  ConsumerState createState() => _BottomPlayerState();
}

class _BottomPlayerState extends ConsumerState<BottomPlayer> with SingleTickerProviderStateMixin {
  late ThemeData _theme;
  final _imageProvider = ValueNotifier<ImageProvider?>(null);
  final _dynamicColors = ValueNotifier<ColorScheme?>(null);
  late final AnimationController animationController;

  final _playProgress = ValueNotifier<double>(0.6);
  final _isPlaying = ValueNotifier<bool>(false);
  final _randomQueue = ValueNotifier<bool>(false);
  final _repeatTrack = ValueNotifier<bool>(false);
  final _likeTrack = ValueNotifier<bool>(false);

  late Size _screenSize;
  late bool _isMobile;
  late bool _isTablet;
  late bool _isDesktop;

  late EdgeInsets _viewPadding;

  Future<void> _onImageProviderChanged() async {
    final imageProvider = _imageProvider.value;
    if (imageProvider != null && mounted) {
      _dynamicColors.value = await ColorScheme.fromImageProvider(
        provider: imageProvider,
        brightness: _theme.brightness,
      );
    }
  }

  Future<void> _onExpand() {
    return showMaterialModalBottomSheet(
      context: context,
      bounce: true,
      expand: true,
      duration: const Duration(milliseconds: 400),
      secondAnimation: animationController,
      builder: (context) => SafeArea(
        top: true,
        child: Column(
          children: [
            Container(
              color: Colors.yellowAccent,
              height: kToolbarHeight,
              child: AppBar(
                leading:  IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(FontAwesomeIcons.chevronDown)),
                title: Consumer(builder: (context, ref, child) {
                  final currentAlbum = ref.watch(currentAlbumControllerProvider);
                  return Text(
                    'Album: ${currentAlbum!.name}',
                    style: const TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w600),
                  );
                }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 30,
                top: 20,
                right: 30,
                bottom: _isMobile ? 20 : 60,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 518),
                child: ValueListenableBuilder(
                  valueListenable: _dynamicColors,
                  builder: (context, colorScheme, child) => Theme(
                      data: Theme.of(context).copyWith(colorScheme: colorScheme),
                      child: Consumer(builder: (context, ref, child) {
                        return StreamBuilder(
                            stream: ref.read(playerProvider).sequenceStateStream,
                            builder: (context, snapshot) {
                              if (snapshot.data?.sequence.isEmpty ?? true) return Container();
                              final currentSong =
                                  snapshot.data?.sequence[snapshot.data!.currentIndex].tag as MediaItem?;

                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: 444),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: ValueListenableBuilder(
                                              valueListenable: _imageProvider,
                                              builder: (context, image, child) => (image == null)
                                                  ? const SizedBox.shrink()
                                                  : Image(
                                                      image: currentSong?.artUri != null
                                                          ? NetworkImage(currentSong!.artUri.toString())
                                                          : const AssetImage(Images.album) as ImageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: _isMobile ? 16 : 28),
                                        IconTheme(
                                          data: _theme.iconTheme.copyWith(
                                            size: _isMobile ? 28 : 24,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              // _openListButton(),
                                              _randomQueueButton(),
                                              _repeatTrackButton(),
                                              // _downloadTrackButton(),
                                              _likeTrackButton(),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: _isMobile ? 16 : 28),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    currentSong?.title ?? '',
                                    style: TextStyle(
                                      fontSize: _isMobile ? 30 : 40,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                  Text(
                                    currentSong?.artist ?? '',
                                    style: TextStyle(
                                      fontSize: _isMobile ? 18 : 24,
                                      height: 1.2,
                                    ),
                                  ),
                                  const PositionSlider(),
                                  SizedBox(height: _isMobile ? 23 : 56),
                                  IconTheme(
                                    data: _theme.iconTheme.copyWith(
                                      size: _isMobile ? 37 : 44,
                                    ),
                                    child: Wrap(
                                      spacing: _isMobile ? 40 : 24,
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: [
                                        _prevTrackButton(),
                                        SizedBox.square(
                                          dimension: _isMobile ? 68 : 72,
                                          child: _playPauseButton(),
                                        ),
                                        _nextTrackButton(),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            });
                      })),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    animationController = BottomSheet.createAnimationController(this);

    _imageProvider.addListener(_onImageProviderChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _imageProvider.value = const AssetImage(Images.songSample));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = Theme.of(context);
    _viewPadding = MediaQuery.viewPaddingOf(context);

    _screenSize = MediaQuery.sizeOf(context);

    final deviceType = getDeviceType(_screenSize);
    _isMobile = deviceType == DeviceScreenType.mobile;
    _isTablet = deviceType == DeviceScreenType.tablet;
    _isDesktop = deviceType == DeviceScreenType.desktop;
  }

  @override
  void dispose() {
    animationController.dispose();
    _imageProvider.dispose();
    _dynamicColors.dispose();
    _playProgress.dispose();
    _isPlaying.dispose();
    _randomQueue.dispose();
    _repeatTrack.dispose();
    _likeTrack.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late final AnimationController animationController = useAnimationController();

    SongsEntity? currentSong;

    final playbackProvider = ref.watch(playbackNotifierProvider);
    _isPlaying.value = playbackProvider.status == PlaybackStatus.playing;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        StreamBuilder<SequenceState?>(
            stream: ref.read(playerProvider).sequenceStateStream,
            builder: (context, snapshot) {
              if (snapshot.data?.sequence.isEmpty ?? true) return Container();
              final currentSong = snapshot.data?.sequence[snapshot.data!.currentIndex].tag as MediaItem?;
              final image = currentSong?.artUri != null
                  ? NetworkImage(currentSong!.artUri.toString())
                  : const AssetImage(Images.emptyItem) as ImageProvider;
              _imageProvider.value = image;
              return Container(
                height: (69) + _viewPadding.bottom,
                color: _theme.bottomSheetTheme.backgroundColor?.withOpacity(0.75),
                // color: Colors.black,
                padding: EdgeInsets.only(bottom: _viewPadding.bottom),
                child: GestureDetector(
                  onTap: !_isDesktop ? () => _onExpand() : null,
                  behavior: HitTestBehavior.opaque,
                  child: SimpleListTile(
                    padding: const EdgeInsets.only(right: 8),
                    leading: AspectRatio(
                      aspectRatio: 1,
                      child: Image(
                        image: image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      currentSong?.title ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      currentSong?.artist ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.2,
                      ),
                    ),
                    trailing: Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        // if (_isDesktop) const RemainingDuration(),
                        // if (_isDesktop) const RandomQueueButton(),
                        _prevTrackButton(),
                        SizedBox.square(
                          dimension: 45,
                          child: _playPauseButton(),
                        ),
                        _nextTrackButton(),
                        // if (_isDesktop) _repeatTrackButton(),
                      ],
                    ),
                    leadingToTitle: 15,
                  ),
                ),
              );
            }),
        ValueListenableBuilder(
            valueListenable: _dynamicColors,
            builder: (context, colorScheme, child) {
              return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: colorScheme,
                  ),
                  child: const Positioned(left: -25, top: -22, right: -25, child: PositionSlider()));
            }),
      ],
    );
  }

  Widget _playPauseButton() => PlayPauseButton(
        onPressed: () => _isPlaying.value
            ? ref.read(playbackNotifierProvider.notifier).pause()
            : ref.read(playbackNotifierProvider.notifier).resume(),
        background: _theme.colorScheme.onPrimary,
        foreground: _theme.colorScheme.secondary,
        stateNotifier: _isPlaying,
      );

  Widget _prevTrackButton() => IconButton(
        onPressed: () => ref.read(playbackNotifierProvider.notifier).prev(),
        color: _theme.colorScheme.onPrimary,
        icon: const Icon(Entypo.fast_backward),
      );

  Widget _nextTrackButton() => IconButton(
        onPressed: () => ref.read(playbackNotifierProvider.notifier).next(),
        color: _theme.colorScheme.onPrimary,
        icon: const Icon(Entypo.fast_forward),
      );

  Widget _openListButton() => IconButton(
        onPressed: () {},
        color: _theme.colorScheme.onPrimary,
        icon: const Icon(CupertinoIcons.list_bullet),
      );

  Widget _randomQueueButton() => StreamBuilder<bool?>(
        stream: ref.read(playerProvider).shuffleModeEnabledStream,
        builder: (context, snapshot) {
          return IconButton(
            onPressed: () =>
                ref.read(playerProvider).setShuffleModeEnabled(snapshot.data == null ? !snapshot.data! : true),
            icon: Icon(
              JPlayer.mix,
              color: _theme.colorScheme.onPrimary,
            ),
            selectedIcon: Icon(
              JPlayer.mix,
              color: _theme.colorScheme.primary,
            ),
            isSelected: snapshot.data ?? false,
          );
        },
      );

  Widget _repeatTrackButton() => StreamBuilder<LoopMode>(
        stream: ref.read(playerProvider).loopModeStream,
        builder: (context, snapshot) {
          return IconButton(
            onPressed: () =>
                ref.read(playerProvider).setLoopMode(snapshot.data == LoopMode.all ? LoopMode.off : LoopMode.all),
            icon: Icon(
              JPlayer.repeat,
              color: _theme.colorScheme.onPrimary,
            ),
            selectedIcon: Icon(
              JPlayer.repeat,
              color: _theme.colorScheme.primary,
            ),
            isSelected: snapshot.data == LoopMode.all,
          );
        },
      );

  Widget _downloadTrackButton() => IconButton(
        onPressed: () {},
        color: _theme.colorScheme.onPrimary,
        icon: const Icon(JPlayer.download),
      );

  Widget _likeTrackButton() => ValueListenableBuilder(
        valueListenable: _likeTrack,
        builder: (context, isLiked, child) => IconButton(
          onPressed: () => _likeTrack.value = !isLiked,
          icon: Icon(
            CupertinoIcons.heart,
            color: _theme.colorScheme.onPrimary,
          ),
          selectedIcon: Icon(
            CupertinoIcons.heart_fill,
            color: _theme.colorScheme.primary,
          ),
          isSelected: isLiked,
        ),
      );
}
