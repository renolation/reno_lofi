import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reno_music/domains/domains.dart';

import '../../state/base_url_provider.dart';
import '../resources/resources.dart';

class LibraryView extends ConsumerWidget {
  const LibraryView({
    required this.library,
    this.onTap,
    super.key,
  });

  final LibraryEntity library;
  final VoidCallback? onTap;

  String? imagePath(WidgetRef ref) {
    if (library.imageTags['Primary'] == null) return null;

    return ref.read(imageProvider).imagePath(tagId: library.imageTags['Primary']!, id: library.id);
  }

  ImageProvider libraryImage(WidgetRef ref) {
    if (imagePath(ref) != null) {
      log(imagePath(ref)!);
      return NetworkImage(imagePath(ref)!);
    }
    return const AssetImage(Images.librarySample);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image(
              image: libraryImage(ref),
              fit: BoxFit.fitWidth,
            ),
          ),
          libraryImage(ref) != const AssetImage(Images.librarySample) ? const SizedBox() : Align(
            alignment: Alignment.center,
            child: Text(
              library.name ?? 'Untitled',
              style: const TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}