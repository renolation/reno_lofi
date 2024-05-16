import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reno_music/state/secure_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/auth.dart';
import '../data/user_credentials.dart';
import '../repositories/auth_repository.dart';
import 'base_url_provider.dart';
import 'current_user_provider.dart';
import 'dio_provider.dart';

part 'auth_controller.g.dart';

const _dummyUser = Auth.signedIn(
  id: '1',
  token: 'some-updated-secret-auth-token',
);

@riverpod
class AuthController extends _$AuthController {
  // late SharedPreferences _sharedPreferences;
  // static const _sharedPrefsKey = 'token';

  late final FlutterSecureStorage _storage;

  static const _serverUrlKey = 'serverUrl';
  static const _userIdKey = 'userId';
  static const _tokenKey = 'x-mediabrowser-token';

  @override
  Future<Auth> build() async {
    // _sharedPreferences = await SharedPreferences.getInstance();
    _storage = ref.read(secureStorageProvider);

    _persistenceRefreshLogic();
    return _loginRecoveryAttempt();

  }

  Future<Auth> _loginRecoveryAttempt()async{
    try {
      final isToken = await _storage.containsKey(key: _tokenKey);
      if(!isToken) throw const UnauthorizedException('No Auth');

      final savedToken = await _storage.read(key: _tokenKey);

      return _loginWithToken(savedToken!);
    } catch (_, __){
      _storage.delete(key: _tokenKey).ignore();
      return Future.value(const Auth.signedOut());
    }
  }

  Future<void> login(String email, String password) async {
    // final result = await Future.delayed(networkRoundTripTime, () => _dummyUser);
    // state = AsyncData(result);
  }

  Future<String?> signIn(UserCredentials userCredentials) async{
    final authRepo = ref.watch(authRepositoryProvider);
    final cancelToken = CancelToken();
    var (id, token) = await authRepo.signIn(
      userCredentials,
      cancelToken: cancelToken,
    );
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _userIdKey, value: id);
    await _storage.write(key: _serverUrlKey, value: userCredentials.serverUrl);

    ref.read(baseUrlProvider.notifier).state = userCredentials.serverUrl;
    ref.read(currentUserProvider.notifier).state = CurrentUser(userId: id, token: token);

    final tokenValidated = _validateAuthToken(token, id);
    if (tokenValidated) _setAuthHeader(token);
    state = AsyncData(Auth.signedIn(id: id, token: token));
    return state.error.toString();
  }

  bool _validateAuthToken(String? token, String userId) {
    // if (token == null) return false;

    // final tokenPayload = JwtDecoder.decode(token);
    // final exp = tokenPayload['exp'] as int?;

    // if (exp == null) return true;
    var tokenValid = false;
    try {
      _setAuthHeader(token!);
      // _api.getArtists(userId: userId);
      tokenValid = true;
      _removeAuthHeader();
    } catch (e) {
      tokenValid = false;
    }

    // final expirationTime = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    // final now = DateTime.now();

    // return expirationTime.isAfter(now);
    return token != null && tokenValid;
  }

  void _setAuthHeader(String token) {
    ref.read(dioProvider).options.headers[_tokenKey] = token;

    if (kDebugMode) _notifyDeveloper();
  }

  void _removeAuthHeader() {
    ref.read(dioProvider).options.headers.remove(_tokenKey);
    if (kDebugMode) _notifyDeveloper();
  }

  void _notifyDeveloper() => log(
    ref.read(dioProvider).options.headers[_tokenKey].toString(),
    name: 'Auth',
  );

  Future<void> logout() async {
    await Future<void>.delayed(networkRoundTripTime);
    state = const AsyncData(Auth.signedOut());
  }
  Future<Auth> _loginWithToken(String token) async {
    final logInAttempt = await Future.delayed(
      networkRoundTripTime,
          () => true, // edit this if you wanna play around
    );

    if (logInAttempt) return _dummyUser;

    throw const UnauthorizedException('401 Unauthorized or something');
  }

  void _persistenceRefreshLogic() {
    ref.listenSelf((_, next) {
      if (next.isLoading) return;
      if (next.hasError) {
        _storage.delete(key: _tokenKey);
        return;
      }

      next.requireValue.map<void>(
        signedIn: (signedIn) => _storage.write(key: _tokenKey, value: signedIn.token),
        signedOut: (signedOut) {
          _storage.delete(key: _tokenKey);
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
