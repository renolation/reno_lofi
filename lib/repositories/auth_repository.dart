import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:reno_music/data/user.dart';
import 'package:reno_music/data/user_credentials.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/auth.dart';
import '../state/dio_provider.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository({required this.client});

  final Dio client;

  Future<(String, String)> signIn(UserCredentials userCredentials, {CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: 'music.renolation.com',
      path: '/Users/AuthenticateByName',
    ).toString();
    print(url);
    var data = {"Username": "renolation", "Pw": "renolation"};
    print(data);
    dev.log(client.options.headers.toString());
    final response = await client.post(url, data: data, cancelToken: cancelToken);
    print(response.statusCode);
    return (response.data["User"]["Id"] as String, response.data["AccessToken"] as String);
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) => AuthRepository(client: ref.watch(dioProvider));
