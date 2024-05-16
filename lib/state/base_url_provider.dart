import 'package:flutter_riverpod/flutter_riverpod.dart';

final baseUrlProvider = StateProvider<String?>((ref) {
  return null;
});

// final imageProvider = Provider<ImageService>((ref) {
//   final url = ref.watch(baseUrlProvider);
//   return ImageService(serverUrl: url!);
// });
