import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reno_music/data/library_entity.dart';
import 'package:reno_music/domain/providers/current_library_provider.dart';
import 'package:reno_music/presentations/widgets/action_button.dart';
import 'package:reno_music/repositories/jellyfin_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../state/secure_storage_provider.dart';
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final future = useMemoized(() => ref.read(jellyfinApiProvider).getLibraries(userId: userId));
    // final snapshot = useFuture(future);

    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
      body: Consumer(builder: (context, ref, child) {
        final data = ref.watch(currentLibraryProviderProvider);
        return data.when(data: (data){
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context,index){
                  LibraryEntity entity = data[index];
                  return Text(data[index].name!);
            });
        }, error: (err, stack) => Text('Error $err'),
            loading: () => Text('loading'),
          );
      }),
    );
  }
}
