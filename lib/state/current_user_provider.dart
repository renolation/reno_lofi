import 'package:flutter_riverpod/flutter_riverpod.dart';


class CurrentUser {
  CurrentUser({required this.userId, required this.token});
  final String userId;
  final String token;
}

final currentUserProvider = StateProvider<CurrentUser?>((ref) => null);