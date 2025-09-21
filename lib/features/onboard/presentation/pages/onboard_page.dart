import 'package:dating_china_app_mvp/core/usecase/usecase.dart';
import 'package:dating_china_app_mvp/features/splash/domain/usecases/complete_onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final complete = Modular.get<CompleteOnboarding>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 96),
            const SizedBox(height: 24),
            const Text(
              'Dating App For China Boys \n& Thai girls #1',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32
              ),
            ),
            const SizedBox(height: 32),
            FilledButton(onPressed: () async {
              await complete(const NoParams());
              Modular.to.navigate('/shell/home/');
            }, 
            child: const Text("Get Started !")),
          ],
        ),
        ),
    );
  }
}