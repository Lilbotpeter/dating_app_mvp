import 'package:dating_china_app_mvp/core/module/feature_base_module.dart';
import 'package:dating_china_app_mvp/features/onboard/presentation/pages/onboard_page.dart';
import 'package:dating_china_app_mvp/features/splash/data/repositories/onboarding_repository_impl.dart';
import 'package:dating_china_app_mvp/features/splash/domain/repositories/onboarding_repository.dart';
import 'package:dating_china_app_mvp/features/splash/domain/usecases/complete_onboarding.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/network/dio_client.dart';
import '../../core/storage/key_value_storage.dart';
import '../splash/data/datasources/onboarding_local_ds.dart';
import '../splash/data/datasources/onboarding_remote_ds.dart';

class OnboardModule extends FeatureBaseModule{
  @override
  void binds(Injector i) {
        i.addLazySingleton<OnboardingLocalDs>(() => OnboardingLocalDs(i<KeyValueStorage>()));
    i.addLazySingleton<OnboardingRemoteDs>(() => OnboardingRemoteDs(i<DioClient>()));

    //Repository
    i.addLazySingleton<OnboardingRepository>(() => OnboardingRepositoryImpl(
      local: i(), 
      remote: i()));
      
    i.addLazySingleton<CompleteOnboarding>(() => CompleteOnboarding(i<OnboardingRepository>()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute, 
      child: (_) => const OnboardPage());
  }
}