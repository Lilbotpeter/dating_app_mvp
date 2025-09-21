import 'package:dating_china_app_mvp/core/error/data_state.dart';

abstract class OnboardingRepository {
  Future<DataState<bool>> isOnboardingDone();
  Future<DataState<void>> setOnboardingDone(bool value);
}