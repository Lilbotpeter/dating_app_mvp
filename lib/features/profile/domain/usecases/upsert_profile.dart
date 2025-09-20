import 'package:dating_china_app_mvp/core/error/data_state.dart';
import 'package:dating_china_app_mvp/core/usecase/usecase.dart';
import 'package:dating_china_app_mvp/features/profile/domain/repositories/profile_repository.dart';

import '../entities/profile.dart';

class UpsertProfileParams {
  final Profile profile;
  const UpsertProfileParams(this.profile);
}

class UpsertProfile implements Usecase<DataState<Profile>, UpsertProfileParams>{
  final ProfileRepository repo;
  UpsertProfile(this.repo);

  @override
  Future<DataState<Profile>> call(UpsertProfileParams params) => repo.upsert(params.profile);
}