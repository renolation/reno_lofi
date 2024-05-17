import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domains/domains.dart';
import '../../repositories/jellyfin_api.dart';
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
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: songs.length,
          itemBuilder: (context, index){
            return Text(songs[index].name!);
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
