import 'package:dating_china_app_mvp/core/error/data_state.dart';
import 'package:dating_china_app_mvp/core/usecase/usecase.dart';
import 'package:dating_china_app_mvp/features/profile/domain/entities/profile.dart';
import 'package:dating_china_app_mvp/features/profile/domain/repositories/profile_repository.dart';

class FetchRemoteProfile implements Usecase<DataState<Profile?>, NoParams>{
  final ProfileRepository repo;
  FetchRemoteProfile(this.repo);

  @override
  Future<DataState<Profile?>> call(NoParams params) => repo.fetchRemote();
}