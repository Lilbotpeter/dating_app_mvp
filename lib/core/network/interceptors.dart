import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

typedef TokenProvider = Future<String?> Function();
typedef TokenRefresher = Future<String?> Function();

class AuthInterceptor extends Interceptor{
  final TokenProvider getToken;
  final TokenRefresher refreshToken;

  AuthInterceptor({required this.getToken,required this.refreshToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    final token = await getToken();
    if(token != null && token.isNotEmpty){
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}

class LoggingInterceptor extends Interceptor{
  final bool enabled;
  LoggingInterceptor({this.enabled = true});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler){
    if(enabled){
      debugPrint('[REQ] ${options.method} ${options.uri} headers=${options.headers}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler){
    if(enabled){
      debugPrint('[RES] ${response.statusCode} ${response.requestOptions.uri}');
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler){
    if(enabled){
      debugPrint('[ERR] ${err.type} ${err.message} @ ${err.requestOptions.uri}');
    }
  }
}

class RetryOnConnectionChangeInterceptor extends Interceptor{
  final Dio dio;
  final int maxRetries;
  final List<int> retryDelays;

  RetryOnConnectionChangeInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryDelays = const [1,2,4],
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if(err.type == DioExceptionType.connectionError){
      var attempt = 0;
      while(attempt < maxRetries){
        await Future.delayed(Duration(seconds: retryDelays[attempt]));
        try{
          final clone = await dio.request(
            err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            options: Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            )
          );
          return handler.resolve(clone);
        }catch(_){
          attempt++;
        }
      }
    }
    handler.next(err);
  }
}

