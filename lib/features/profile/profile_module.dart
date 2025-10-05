import 'package:dating_china_app_mvp/core/module/feature_base_module.dart';
import 'package:dating_china_app_mvp/core/network/dio_client.dart';
import 'package:dating_china_app_mvp/features/profile/data/datasources/profile_local_ds.dart';
import 'package:dating_china_app_mvp/features/profile/data/datasources/profile_remote_ds.dart';
import 'package:dating_china_app_mvp/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:dating_china_app_mvp/features/profile/domain/repositories/profile_repository.dart';
import 'package:dating_china_app_mvp/features/profile/domain/usecases/fetch_remote_profile.dart';
import 'package:dating_china_app_mvp/features/profile/domain/usecases/get_local_profile.dart';
import 'package:dating_china_app_mvp/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dating_china_app_mvp/features/profile/presentation/pages/profile_overview_page.dart';
import 'package:dating_china_app_mvp/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/clear_profile.dart';
import 'domain/usecases/upsert_profile.dart';

class ProfileModule extends FeatureBaseModule{
  
  @override
  void binds(Injector i) {

    //Data Source
    i.addLazySingleton<ProfileLocalDs>(() => ProfileLocalDs());
    i.addLazySingleton<ProfileRemoteDs>(() => ProfileRemoteDs(i<DioClient>()));

    //Repository
    i.addLazySingleton<ProfileRepository>(() => 
      ProfileRepositoryImpl(local: i<ProfileLocalDs>(), remote: i<ProfileRemoteDs>()));

    //UseCases
    i.addLazySingleton<GetLocalProfile>(() => GetLocalProfile(i<ProfileRepository>()));
    i.addLazySingleton<FetchRemoteProfile>(() => FetchRemoteProfile(i<ProfileRepository>()));
    i.addLazySingleton<UpsertProfile>(() => UpsertProfile(i<ProfileRepository>()));
    i.addLazySingleton<ClearProfile>(() => ClearProfile(i<ProfileRepository>()));

    //Bloc
    i.add<ProfileBloc>(() => ProfileBloc(
      getLocal: i<GetLocalProfile>(), 
      fetchRemote: i<FetchRemoteProfile>(), 
      upsert: i<UpsertProfile>(), 
      clear: i<ClearProfile>()
      
    ));

  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute, 
      child: (_){
        final bloc = Modular.get<ProfileBloc>();
        return BlocProvider.value(
          value: bloc,
          child: const ProfileOverviewPage(),
        );
      });
    
    r.child(
      '/edit', 
      child: (_){
      final bloc = Modular.get<ProfileBloc>();
      return BlocProvider.value(
        value: bloc,
        child: const ProfilePage(),
        );
    });
  }
}