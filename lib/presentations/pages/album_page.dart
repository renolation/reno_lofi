import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reno_music/domain/providers/albums_libraries_provider.dart';
import 'package:reno_music/domain/providers/list_library_provider.dart';

import '../../data/item_entity.dart';

class AlbumPage extends ConsumerWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Album Page'),
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              // final libId = ref.read(selectingLibraryControllerProvider);
              final data = ref.watch(albumsLibrariesProviderProvider);
                return data.when(data: (data){
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index){
                    final ItemEntity item = data[index];
                    return Text(item.name);
                  });
                }, error: (err, stack) => Text('Error $err'),
                  loading: () => Text('loading'),
                );
              }),
          )
          ],
      ),),
    );
  }
}
