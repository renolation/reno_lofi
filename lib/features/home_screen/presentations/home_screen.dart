import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:reno_music/utils/constants.dart';

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
            Text(
              'Browse',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 30,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  for (var text in listTab)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                                imageUrl:
                                    'https://b2.renolation.com/file/music-reno/kristaps-ungurs-hqXqJ5QTeQQ-unsplash.jpg',
                                width: 130,
                                height: 130,
                                fit: BoxFit.cover),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Flower Boy',
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
          ],
        ),
      ),
    );
  }
}
