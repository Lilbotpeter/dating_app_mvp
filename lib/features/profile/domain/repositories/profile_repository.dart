import 'package:dating_china_app_mvp/core/error/data_state.dart';
import 'package:dating_china_app_mvp/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<DataState<Profile?>> getLocal();
  Future<DataState<Profile?>> fetchRemote();
  Future<DataState<Profile>> upsert(Profile profile);
  Future<DataState<void>> clear();
}