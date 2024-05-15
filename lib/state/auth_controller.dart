import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/auth.dart';

part 'auth_controller.g.dart';

const _dummyUser = Auth.signedIn(
  id: -1,
  displayName: 'My Name',
  email: 'My Email',
  token: 'some-updated-secret-auth-token',
);

@riverpod
class AuthController extends _$AuthController {
  late SharedPreferences _sharedPreferences;
  static const _sharedPrefsKey = 'token';

  @override
  Future<Auth> build() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _persistenceRefreshLogic();
    return _loginRecoveryAttempt();

  }

  Future<Auth> _loginRecoveryAttempt(){
    try {
      final savedToken = _sharedPreferences.getString(_sharedPrefsKey);
      if(savedToken == null) throw const UnauthorizedException('No Auth');

      return _loginWithToken(savedToken);
    } catch (_, __){
      _sharedPreferences.remove(_sharedPrefsKey).ignore();
      return Future.value(const Auth.signedOut());
    }
  }

  Future<void> login(String email, String password) async {
    final result = await Future.delayed(networkRoundTripTime, () => _dummyUser);
    state = AsyncData(result);
  }


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
        _sharedPreferences.remove(_sharedPrefsKey);
        return;
      }

      next.requireValue.map<void>(
        signedIn: (signedIn) => _sharedPreferences.setString(_sharedPrefsKey, signedIn.token),
        signedOut: (signedOut) {
          _sharedPreferences.remove(_sharedPrefsKey);
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
