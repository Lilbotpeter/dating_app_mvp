import 'package:dating_china_app_mvp/app/shell.dart';
import 'package:dating_china_app_mvp/core/env/app_config.dart';
import 'package:dating_china_app_mvp/core/network/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthLocalDS{
  Future<String?> getAccessToken() async => null;
  Future<String?> refreshToken() async => null;
}

class AppModule extends Module {
  final AppConfig config;

  AppModule(this.config);

  @override
  void binds(Injector i) {
    //Auth store
    i.addLazySingleton<AuthLocalDS>(() => AuthLocalDS());

    //Network
    i.addSingleton<NetworkErrorHandler>(() => NetworkErrorHandler());
    i.addLazySingleton<DioClient>(() => DioClient(
      baseUrl: config.baseUrl, 
      getToken: () => i <AuthLocalDS>().getAccessToken(), 
      refreshToken: () => i<AuthLocalDS>().refreshToken(),
      enableLog: !config.isProd,
      ));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_)=> const AppShell(),
      children: [
        //Home stub waiting for features
        ChildRoute('/home', child: (_) => const _HomeStub()),
        ChildRoute('/profile', child: (_) => const _Profile())
      ],
      );
  }
}

class _HomeStub extends StatelessWidget {
  const _HomeStub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Core+App Ready\n(plug features later)',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile({super.key});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Profile Ready\n(plug features later)',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}