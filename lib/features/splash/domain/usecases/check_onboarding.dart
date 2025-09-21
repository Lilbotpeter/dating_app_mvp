import 'package:dating_china_app_mvp/core/error/data_state.dart';
import 'package:dating_china_app_mvp/core/usecase/usecase.dart';
import 'package:dating_china_app_mvp/features/splash/domain/repositories/onboarding_repository.dart';

class CheckOnboarding implements Usecase<DataState<bool>, NoParams>{
  final OnboardingRepository repo;
  CheckOnboarding(this.repo);
  
  @override
  Future<DataState<bool>> call(NoParams params) => repo.isOnboardingDone();
  
  }
  

  