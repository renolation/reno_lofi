import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reno_music/state/secure_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';


import '../domains/domains.dart';
import '../repositories/auth_repository.dart';
import '../repositories/jellyfin_api.dart';
import 'base_url_provider.dart';
import 'current_user_provider.dart';
import 'dio_provider.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  // late SharedPreferences _sharedPreferences;
  // static const _sharedPrefsKey = 'token';

  late final FlutterSecureStorage _storage;

  static const _serverUrlKey = 'serverUrl';
  static const _userIdKey = 'userId';
  // static const _tokenKey = 'x-mediabrowser-token';

  @override
  Future<Auth> build() async {
    // _sharedPreferences = await SharedPreferences.getInstance();
    _storage = ref.read(secureStorageProvider);

    _persistenceRefreshLogic();
    return _loginRecoveryAttempt();

  }

  Future<Auth> _loginRecoveryAttempt()async{
    try {
      final isSavedUserId = await _storage.containsKey(key: _userIdKey);
      if(!isSavedUserId) throw const UnauthorizedException('No Auth');

      // final savedToken = await _storage.read(key: _tokenKey);
      final savedUserId = await _storage.read(key: _userIdKey);
      final savedBaseUrl = await _storage.read(key: _serverUrlKey);

      ref.read(currentUserProvider.notifier).state = savedUserId;
      ref.read(baseUrlProvider.notifier).state = savedBaseUrl;

      return Auth.signedIn(id: savedUserId!);
    } catch (_, __){
      _storage.delete(key: _userIdKey).ignore();
      return Future.value(const Auth.signedOut());
    }
  }

  Future<(String?, String?)> getKeys() async {
    // final savedToken = await _storage.read(key: _tokenKey);
    final savedUserId = await _storage.read(key: _userIdKey);
    final savedBaseUrl = await _storage.read(key: _serverUrlKey);
    return (savedUserId, savedBaseUrl);
  }


  Future<String?> signIn(UserCredentials userCredentials) async{
    final authRepo = ref.watch(authRepositoryProvider);
    final cancelToken = CancelToken();
    var (id) = await authRepo.signIn(
      userCredentials,
      cancelToken: cancelToken,
    );
    // await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _userIdKey, value: id);
    await _storage.write(key: _serverUrlKey, value: userCredentials.serverUrl);

    ref.read(baseUrlProvider.notifier).state = userCredentials.serverUrl;
    ref.read(currentUserProvider.notifier).state = id;

    // final tokenValidated = _validateAuthToken(token, id);
    // if (tokenValidated) _setAuthHeader(token);
    state = AsyncData(Auth.signedIn(id: id));
    return state.error.toString();
  }

  bool _validateAuthToken(String? token, String userId) {
    // if (token == null) return false;

    // final tokenPayload = JwtDecoder.decode(token);
    // final exp = tokenPayload['exp'] as int?;

    // if (exp == null) return true;
    var tokenValid = false;
    final jellyApi = ref.watch(jellyfinApiProvider);

    try {
      // _setAuthHeader(token!);
      jellyApi.getArtists(userId: userId);
      tokenValid = true;
      // _removeAuthHeader();
    } catch (e) {
      tokenValid = false;
    }

    // final expirationTime = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    // final now = DateTime.now();

    // return expirationTime.isAfter(now);
    return token != null && tokenValid;
  }

  // void _setAuthHeader(String token) {
  //   ref.read(dioProvider).options.headers[_tokenKey] = token;
  //   print('tokenKey $token');
  //   if (kDebugMode) _notifyDeveloper();
  // }
  //
  // void _removeAuthHeader() {
  //   ref.read(dioProvider).options.headers.remove(_tokenKey);
  //   if (kDebugMode) _notifyDeveloper();
  // }
  //
  // void _notifyDeveloper() => log(
  //   ref.read(dioProvider).options.headers[_tokenKey].toString(),
  //   name: 'Auth',
  // );

  Future<void> logout() async {
    await Future<void>.delayed(networkRoundTripTime);
    state = const AsyncData(Auth.signedOut());
  }
  Future<Auth> _loginWithToken(String userId) async {
    final logInAttempt = await Future.delayed(
      networkRoundTripTime,
          () => true, // edit this if you wanna play around
    );

    if (logInAttempt) return Auth.signedIn(id: userId);

    throw const UnauthorizedException('401 Unauthorized or something');
  }

  void _persistenceRefreshLogic() {
    ref.listenSelf((_, next) {
      if (next.isLoading) return;
      if (next.hasError) {
        _storage.delete(key: _userIdKey);
        return;
      }

      next.requireValue.map<void>(
        signedIn: (signedIn) => _storage.write(key: _userIdKey, value: signedIn.id),
        signedOut: (signedOut) {
          _storage.delete(key: _userIdKey);
        },
      );
    });
  }
}

class UnauthorizedException implements Exception {
  const UnauthorizedException(this.message);
  final String message;
}
final networkRoundTripTime = 2.seconds;
