import 'package:dating_china_app_mvp/app/app_module.dart';
import 'package:dating_china_app_mvp/app/app_widget.dart';
import 'package:dating_china_app_mvp/core/env/app_config.dart';
import 'package:dating_china_app_mvp/core/storage/hive_box_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final config = AppConfig.fromEnv();

  await Hive.openBox(HiveBoxNames.profile);

  runApp(ModularApp(module: AppModule(config), child: const AppWidget()));
}

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text('Hello World!'),
//         ),
//       ),
//     );
//   }
// }
