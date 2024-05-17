import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import '../../data/list_library_provider.dart';
import '../../domains/domains.dart';
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
        final data = ref.watch(listLibraryProviderProvider);
        return data.when(data: (data){
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context,index){
                  final LibraryEntity entity = data[index];
                  return InkWell(
                      onTap: () async {
                         ref.read(selectingLibraryControllerProvider.notifier).setSelectLibrary(entity).then((value) => context.goNamed('albums'));
                      },
                      child: Card(child: Text(data[index].name!)));
            });
        }, error: (err, stack) => Text('Error $err'),
            loading: () => Text('loading'),
          );
      }),
    );
  }
}
