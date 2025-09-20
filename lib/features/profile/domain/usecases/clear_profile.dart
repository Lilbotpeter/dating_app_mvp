import 'package:dating_china_app_mvp/core/error/data_state.dart';
import 'package:dating_china_app_mvp/core/usecase/usecase.dart';
import 'package:dating_china_app_mvp/features/profile/domain/repositories/profile_repository.dart';

class ClearProfile implements Usecase<DataState<void>,NoParams>{
  final ProfileRepository repo;
  ClearProfile(this.repo);

  @override
  Future<DataState<void>> call(NoParams params) => repo.clear();
}