import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/logger_interceptor.dart';
part 'dio_provider.g.dart';


@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final dio = Dio(
    BaseOptions(
      headers: {
        'Authorization':
        'MediaBrowser Token="0aeeaf005a3f4d96af081e9e3f61ff1d"'
      },
    )
  );
  dio.interceptors.add(LoggerInterceptor());
  return dio;
}


//todo: update
const int limitPerCall = 40;