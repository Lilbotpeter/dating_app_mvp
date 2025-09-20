import 'package:dating_china_app_mvp/core/env/app_config.dart';
import 'package:dating_china_app_mvp/core/module/core_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class FeatureBaseModule extends Module {
  @override
  List<Module> get imports => [
    CoreModule(Modular.get<AppConfig>())
  ];
}