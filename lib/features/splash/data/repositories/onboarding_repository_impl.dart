import 'package:dating_china_app_mvp/core/error/data_state.dart';
import 'package:dating_china_app_mvp/features/splash/data/datasources/onboarding_local_ds.dart';
import 'package:dating_china_app_mvp/features/splash/data/datasources/onboarding_remote_ds.dart';
import 'package:dating_china_app_mvp/features/splash/domain/repositories/onboarding_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OnboardingRepositoryImpl implements OnboardingRepository{
  final OnboardingLocalDs local;
  final OnboardingRemoteDs remote;

  OnboardingRepositoryImpl({
    required this.local,
    required this.remote,
  });

  @override
Future<DataState<bool>> isOnboardingDone() async {
  try {
    final cached = await local.isDone();
    var result = cached;
    try {
      final remoteStatus = await remote.fetchStatus();
      if (remoteStatus != cached) {
        if (remoteStatus || !cached) {
          await local.setDone(remoteStatus);
          result = remoteStatus;
        }
      }
    } on DioException catch (e) {
      debugPrint('Remote failed: ${e.message}');  
    }

    return DataSuccess(result);
  } catch (e) {
    return DataFailed(DioException(
      requestOptions: RequestOptions(path: '/onboard/local'),
      error: e,
    ));
  }
}


///waiting for real api

  // @override
  // Future<DataState<bool>> isOnboardingDone() async {
  //   try{
  //     final res = await remote.fetchStatus();
  //     await local.setDone(res);
  //     return DataSuccess<bool>(res);
  //   } on DioException catch(e){
  //     final cache = await local.isDone();
  //     if(cache == true || cache == false) return DataSuccess<bool>(cache);
  //     return DataFailed(e);
  //   }catch(e){
  //     return DataFailed(
  //       DioException(
  //         requestOptions: RequestOptions(),
  //         type: DioExceptionType.unknown,
  //         error: e,
  //         ));
  //   }
  // }

  @override
  Future<DataState<void>> setOnboardingDone(bool value) async{
    debugPrint("setOnboardingDone value : $value");
    await local.setDone(value);
    try{
      await remote.sendDone(value);
      return DataSuccess(null);
    } on DioException catch(e){
      debugPrint("setOnboardingDone DioException $e");
      return DataSuccess(null);
    }catch(e){
      debugPrint("setOnboardingDone Exception $e");
      return DataFailed(DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.unknown,
        error: e,
      ));
    }
  }
  
}