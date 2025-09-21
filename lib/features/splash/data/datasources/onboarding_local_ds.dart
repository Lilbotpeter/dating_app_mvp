import 'package:dating_china_app_mvp/core/storage/key_value_storage.dart';

class OnboardingLocalDs {
  static const key = 'onboarding_done';
  final KeyValueStorage kv;
  OnboardingLocalDs(this.kv);

  Future<bool> isDone() async => await kv.get<bool>(key) ?? false;
  Future<void> setDone(bool value) => kv.set<bool>(key, value);
}