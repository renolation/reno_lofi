import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/logger_interceptor.dart';
part 'dio_provider.g.dart';


@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final dio = Dio(
    BaseOptions(
      headers: {
        'X-Emby-Authorization':
        'MediaBrowser Client="Jellyfin Web", Device="Chrome", DeviceId="TW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzExNy4wLjAuMCBTYWZhcmkvNTM3LjM2fDE2OTcyODE5MTQ0NTA1", Version="10.8.10"'
      },
    )
  );
  dio.interceptors.add(LoggerInterceptor());
  return dio;
}
