import 'package:dating_china_app_mvp/core/module/feature_base_module.dart';
import 'package:dating_china_app_mvp/core/network/dio_client.dart';
import 'package:dating_china_app_mvp/core/storage/key_value_storage.dart';
import 'package:dating_china_app_mvp/features/splash/data/datasources/onboarding_local_ds.dart';
import 'package:dating_china_app_mvp/features/splash/data/datasources/onboarding_remote_ds.dart';
import 'package:dating_china_app_mvp/features/splash/data/repositories/onboarding_repository_impl.dart';
import 'package:dating_china_app_mvp/features/splash/domain/repositories/onboarding_repository.dart';
import 'package:dating_china_app_mvp/features/splash/domain/usecases/check_onboarding.dart';
import 'package:dating_china_app_mvp/features/splash/domain/usecases/complete_onboarding.dart';
import 'package:dating_china_app_mvp/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:dating_china_app_mvp/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends FeatureBaseModule {

  @override
  // TODO: implement imports
  List<Module> get imports => super.imports;

  @override
  void binds(Injector i) {

    //Data source
    i.addLazySingleton<OnboardingLocalDs>(() => OnboardingLocalDs(i<KeyValueStorage>()));
    i.addLazySingleton<OnboardingRemoteDs>(() => OnboardingRemoteDs(i<DioClient>()));

    //Repository
    i.addLazySingleton<OnboardingRepository>(() => OnboardingRepositoryImpl(
      local: i(), 
      remote: i()));

    //UseCases
    i.addLazySingleton<CheckOnboarding>(() => CheckOnboarding(i()));
    i.addLazySingleton<CompleteOnboarding>(() => CompleteOnboarding(i()));

    //Bloc
    i.add<SplashBloc>(() => SplashBloc(i()));
  } 

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute, 
      child: (_){
        final bloc = Modular.get<SplashBloc>();
        return BlocProvider.value(
          value: bloc,
          child: const SplashPage(),
          );
      });
  }

}