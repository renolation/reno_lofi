import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reno_music/state/playback_provider.dart';

import '../../domains/domains.dart';
import '../../repositories/jellyfin_api.dart';
import '../../state/base_url_provider.dart';
import '../../state/current_user_provider.dart';

class AlbumPage extends ConsumerStatefulWidget {
  const AlbumPage({super.key, required this.album});
  final ItemEntity album;
  @override
  ConsumerState createState() => _AlbumPageState();
}

class _AlbumPageState extends ConsumerState<AlbumPage> {

  List<SongsEntity> songs = [];


  @override
  void initState() {
    super.initState();
    _getSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album: ${widget.album.name}'),
      ),
      body: ListView.builder(
        itemCount: songs.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap: () async {

                print(ref.read(baseUrlProvider)!);
                print('cac');
                ref.read(playbackNotifierProvider.notifier).play(songs[index], songs, widget.album);
              },
                child: SizedBox(
                  height: 50,
                  child: Column(
                    children: [
                      Text(songs[index].name!),
                      // Text(songs[index].)
                    ],
                  ),
                ));
          }
      ),
    );
  }

  void _getSongs() {
    ref.read(jellyfinApiProvider).getSongs(userId: ref.read(currentUserProvider.notifier).state!.userId, albumId: widget.album.id).then((value) {
      setState(() {
        final items = [...value.items]..sort((a, b) => a.indexNumber.compareTo(b.indexNumber));
        songs = items;
      });
    });
  }

}
