import 'package:dating_china_app_mvp/core/error/data_state.dart';
import 'package:dating_china_app_mvp/core/usecase/usecase.dart';
import 'package:dating_china_app_mvp/features/splash/domain/repositories/onboarding_repository.dart';

class CompleteOnboarding implements Usecase<DataState<void>,NoParams>{
  final OnboardingRepository repo;
  CompleteOnboarding(this.repo);
  
  @override
  Future<DataState<void>> call(NoParams param) => repo.setOnboardingDone(true);
}