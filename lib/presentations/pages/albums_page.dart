import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


import '../../data/albums_libraries_provider.dart';
import '../../domains/domains.dart';

class AlbumsPage extends ConsumerWidget {
  const AlbumsPage({super.key});

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
              final data = ref.watch(albumsLibrariesProviderProvider);
                return data.when(data: (data){
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index){
                    final ItemEntity item = data[index];
                    return InkWell(
                        onTap: (){
                          // context.goNamed('album');
                          final location = GoRouterState.of(context).fullPath;
                          // ref.read(currentAlbumProvider.notifier).setAlbum(album);
                          context.go('$location/album', extra: {'album': item});
                        },
                        child: Text(item.name));
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
