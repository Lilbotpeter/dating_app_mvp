import 'package:dating_china_app_mvp/core/network/dio_client.dart';
import 'package:dio/dio.dart';

class OnboardingRemoteDs {
  static bool _mockDone = false;
  final Dio _dio;
  OnboardingRemoteDs(DioClient client) : _dio = client.dio;

  Future<bool> fetchStatus() async {
    // For Real Api connect
    // final res = await _dio.get('/onboard/');
    // if(res.data == null) return false;
    // return (res.data['done'] as bool?) ?? false;

    // Mock Result
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return _mockDone;
  }

  Future<void> sendDone (bool value) async {
    // For Real Api connect
    // await _dio.post('/onboarding/complete', data: {'done' : value});
    
    // Mock Result
    await Future<void>.delayed(const Duration(milliseconds: 50));
    _mockDone = value;
  }
}