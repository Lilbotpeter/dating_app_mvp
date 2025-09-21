import 'package:dating_china_app_mvp/app/shell.dart';
import 'package:dating_china_app_mvp/core/env/app_config.dart';
import 'package:dating_china_app_mvp/features/onboard/onboard_module.dart';

import 'package:dating_china_app_mvp/features/profile/profile_module.dart';
import 'package:dating_china_app_mvp/features/splash/splash_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/module/core_module.dart';
import 'package:dating_china_app_mvp/core/network/dio_client.dart';

class AuthLocalDS{
  Future<String?> getAccessToken() async => null;
  Future<String?> refreshToken() async => null;
}

class AppModule extends Module {
  final AppConfig config;
  AppModule(this.config);

  @override
  List<Module> get imports => [
        CoreModule(config),
      ];
  
  @override
  void binds(Injector i) {
    i.addInstance<AppConfig>(config);

  }

  @override
  void routes(r) {
    r.module(Modular.initialRoute, module: SplashModule());
    r.module('/onboard/', module: OnboardModule());
    r.child(
      '/shell/',
      transition: TransitionType.noTransition,
      child: (_)=> const AppShell(),
      children: [
        //Home stub waiting for features
        ChildRoute('/home/', child: (_) => const _HomeStub()),
        ModuleRoute('/profile/', module: ProfileModule()),
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
        child: ElevatedButton(
        onPressed: () {
          try {
            final dc = Modular.get<DioClient>();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Dio OK: ${dc.dio.options.baseUrl}')),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Dio NG: $e')),
            );
          }
        },
        child: const Text('Test DioClient'),
      )
      ),
    );
  }
}