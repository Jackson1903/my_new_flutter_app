import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true) // keepAlive: true hace que sea singleton
Dio dio(DioRef ref) {
  final dio = Dio();

  // Configuración base del cliente HTTP
  dio.options.baseUrl = 'http://localhost:3000';
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 3);
  dio.options.sendTimeout = const Duration(seconds: 3);

  // Headers por defecto
  dio.options.headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Interceptors para logging
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: false,
      responseHeader: false,
      error: true,
    ),
  );

  return dio;
}
