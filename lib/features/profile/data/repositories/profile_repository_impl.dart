import 'package:dating_china_app_mvp/core/error/data_state.dart';
import 'package:dating_china_app_mvp/features/profile/data/datasources/profile_local_ds.dart';
import 'package:dating_china_app_mvp/features/profile/data/datasources/profile_remote_ds.dart';
import 'package:dating_china_app_mvp/features/profile/data/mappers/profile_mapper.dart';
import 'package:dating_china_app_mvp/features/profile/domain/entities/profile.dart';
import 'package:dating_china_app_mvp/features/profile/domain/repositories/profile_repository.dart';
import 'package:dio/dio.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  final ProfileLocalDs local;
  final ProfileRemoteDs remote;

  ProfileRepositoryImpl({required this.local, required this.remote});

  @override
  Future<DataState<Profile?>> getLocal() async {
    try{
      final dto = await local.get();
      return DataSuccess(dto?.toEntity());
    }catch(e){
      return DataFailed(DioException(
        requestOptions: RequestOptions(path: '/profiles/local'),
        error: e,
      ));
    }
  }

  @override
  Future<DataState<Profile?>> fetchRemote() async {
    try{
      final dto = await remote.fetch();
      if(dto != null) await local.put(dto);
      return DataSuccess(dto?.toEntity());
    } on DioException catch (e){
      return DataFailed(e);
    }catch(e){
      return DataFailed(DioException(
        requestOptions: RequestOptions(path: '/profiles/me'),
        error: e,
      ));
    }
  }

  @override
  Future<DataState<Profile>> upsert(Profile profile) async {
    try{
      //optimistic : write local first
      await local.put(profile.toDto());
      try{
        final saved = await remote.upsert(profile.toDto());
        await local.put(saved);
        return DataSuccess(saved.toEntity());
      }on DioException{
        //internet failed but show user success because local has been saved successfully.
        return DataSuccess(profile);
      }
    }catch(e){
      return DataFailed(DioException(
        requestOptions: RequestOptions(path: '/profiles'),
        error: e
      ));
    }
  }

  @override
  Future<DataState<void>> clear() async {
    try{
      await local.clear();
      return const DataSuccess(null);
    }catch(e){
      return DataFailed(DioException(
        requestOptions: RequestOptions(path: '/profiles/clear'),
        error: e
      ));
    }
  }

}