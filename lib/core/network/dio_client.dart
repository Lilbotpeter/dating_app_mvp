import 'package:dating_china_app_mvp/core/network/interceptors.dart';
import 'package:dio/dio.dart';

class DioClient {
  DioClient({
    required String baseUrl,
    required TokenProvider getToken,
    required TokenRefresher refreshToken,
    bool enableLog = true,
  }){
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Accept' : 'application/json'},
    ));

    _dio.interceptors.addAll([
      
    ]);
  }
  late final Dio _dio;
  Dio get dio => _dio;
}

class NetworkErrorHandler{
  String messageFrom(DioException err){
    switch (err.type){
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout, please try again';
      case DioExceptionType.sendTimeout:
        return 'Send timeout, please try again';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout, please try again';
      case DioExceptionType.badResponse:
       final code = err.response?.statusCode;
       if(code != null){
        return 'Server error ($code)';
       }
       return 'Bad response from server';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return 'Network error, please check your internet connection';
      }
    }
  }