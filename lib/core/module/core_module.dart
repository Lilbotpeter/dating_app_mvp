import 'package:dating_china_app_mvp/core/env/app_config.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:dating_china_app_mvp/core/network/dio_client.dart';

class AuthLocalDS {
  //Mock local storage auth
  Future<String?> getAccessToken() async => null;
  Future<String?> refreshToken() async => null;
}

class CoreModule extends Module {
  final AppConfig config;
  CoreModule(this.config);

  @override
  void binds(Injector i) {
    //Auth store
    i.addLazySingleton<AuthLocalDS>(() => AuthLocalDS());

    //Network
    i.addSingleton<NetworkErrorHandler>(() => NetworkErrorHandler());

    i.addLazySingleton<DioClient>(() => DioClient(
          baseUrl: config.baseUrl,
          getToken: () => i<AuthLocalDS>().getAccessToken(),
          refreshToken: () => i<AuthLocalDS>().refreshToken(),
          enableLog: !config.isProd,
        ));
  }
}