import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reno_music/domains/domains.dart';

import 'package:responsive_builder/responsive_builder.dart';

import '../../state/base_url_provider.dart';
import '../resources/resources.dart';

class AlbumsView extends ConsumerWidget {
  const AlbumsView({
    required this.album,
    this.onTap,
    this.mainTextStyle,
    this.subTextStyle,
    this.showArtist = true,
    super.key,
  });

  final ItemEntity album;
  final bool showArtist;
  final VoidCallback? onTap;
  final TextStyle? mainTextStyle;
  final TextStyle? subTextStyle;

  String? imagePath(WidgetRef ref) {
    if (album.imageTags['Primary'] == null) return null;

    return ref.read(imageProvider).imagePath(tagId: album.imageTags['Primary']!, id: album.id);
  }

  ImageProvider libraryImage(WidgetRef ref) {
    if (imagePath(ref) != null) return NetworkImage(imagePath(ref)!);

    return const AssetImage(Images.album);
  }

  String get artistName {
    if (showArtist) {
      return album.albumArtist ?? '';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceType = getDeviceType(MediaQuery.sizeOf(context));
    final isTablet = deviceType == DeviceScreenType.tablet;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: libraryImage(ref),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4,),
          Text(
            album.name,
            style: TextStyle(
              fontSize: isTablet ? 24 : 16,
              fontWeight: FontWeight.w500,
              height: 1.2,
              overflow: TextOverflow.ellipsis,
            ).merge(mainTextStyle),
            maxLines: 1,
          ),

          Text(
            artistName,
            style: TextStyle(
              fontSize: isTablet ? 22 : 14,
              fontWeight: FontWeight.w400,
              height: 1.2,
              color: const Color.fromARGB(130, 255, 255, 255),
              overflow: TextOverflow.ellipsis,
            ).merge(subTextStyle),
          ),
        ],
      ),
    );
  }
}
