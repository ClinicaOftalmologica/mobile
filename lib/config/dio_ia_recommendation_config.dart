// lib/config/dio_config.dart

import 'package:dio/dio.dart';

import '../share_preferens/user_preferences.dart';

class DioConfig {
  //   static const String baseUrl = 'http://10.0.2.2:5000';
  static const String baseUrl = 'http://192.168.0.202:3000';

  static Map<String, dynamic> getHeaders() {
    final prefs = UserPreferences();
    final token = prefs.token;
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  static const String contentType = 'application/json; charset=UTF-8';

  static final dioWithoutAuthorization = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    contentType: contentType,
  ));

  static final dioWithAuthorization = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
    headers: getHeaders(),
    contentType: contentType,
  ));
}
