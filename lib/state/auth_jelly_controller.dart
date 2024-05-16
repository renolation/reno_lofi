// import 'dart:developer';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:reno_music/data/user.dart';
// import 'package:reno_music/data/user_credentials.dart';
// import 'package:reno_music/repositories/auth_repository.dart';
// import 'package:reno_music/state/current_user_provider.dart';
// import 'package:reno_music/state/dio_provider.dart';
// import 'package:reno_music/state/secure_storage_provider.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// import 'base_url_provider.dart';
//
// part 'auth_jelly_controller.g.dart';
//
// @Riverpod(keepAlive: true)
// class AuthJellyController extends _$AuthJellyController {
//
//   late final FlutterSecureStorage _storage;
//
//   static const _serverUrlKey = 'serverUrl';
//   static const _userIdKey = 'userId';
//   static const _tokenKey = 'x-mediabrowser-token';
//
//   @override
//   FutureOr<AsyncValue<bool?>> build() async {
//     _storage = ref.read(secureStorageProvider);
//     return const AsyncValue<bool?>.data(false);
//   }
//
//
//
//   Future<String?> signIn(UserCredentials userCredentials) async{
//     final authRepo = ref.watch(authRepositoryProvider);
//     final cancelToken = CancelToken();
//     var (response, token) = await authRepo.signIn(
//       userCredentials,
//       cancelToken: cancelToken,
//     );
//     await _storage.write(key: _tokenKey, value: token);
//     await _storage.write(key: _userIdKey, value: response.id);
//     await _storage.write(key: _serverUrlKey, value: userCredentials.serverUrl);
//
//     ref.read(baseUrlProvider.notifier).state = userCredentials.serverUrl;
//     ref.read(currentUserProvider.notifier).state = CurrentUser(userId: response.id, token: token);
//
//     final tokenValidated = _validateAuthToken(token, response.id);
//     if (tokenValidated) _setAuthHeader(token);
//     state = AsyncValue<bool>.data(tokenValidated);
//
//     return state.error.toString();
//   }
//
//   bool _validateAuthToken(String? token, String userId) {
//     // if (token == null) return false;
//
//     // final tokenPayload = JwtDecoder.decode(token);
//     // final exp = tokenPayload['exp'] as int?;
//
//     // if (exp == null) return true;
//     var tokenValid = false;
//     try {
//       _setAuthHeader(token!);
//       // _api.getArtists(userId: userId);
//       tokenValid = true;
//       _removeAuthHeader();
//     } catch (e) {
//       tokenValid = false;
//     }
//
//     // final expirationTime = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
//     // final now = DateTime.now();
//
//     // return expirationTime.isAfter(now);
//     return token != null && tokenValid;
//   }
//
//   void _setAuthHeader(String token) {
//     ref.read(dioProvider).options.headers[_tokenKey] = token;
//
//     if (kDebugMode) _notifyDeveloper();
//   }
//
//   void _removeAuthHeader() {
//     ref.read(dioProvider).options.headers.remove(_tokenKey);
//     if (kDebugMode) _notifyDeveloper();
//   }
//
//   void _notifyDeveloper() => log(
//     ref.read(dioProvider).options.headers[_tokenKey].toString(),
//     name: 'Auth',
//   );
// }