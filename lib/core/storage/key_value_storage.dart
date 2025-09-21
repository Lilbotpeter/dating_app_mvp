import 'package:dating_china_app_mvp/core/storage/hive_box_name.dart';
import 'package:hive/hive.dart';

class KeyValueStorage {
  static const _boxName = HiveBoxNames.appPrefs;

  Future<Box> _box() async {
    if(!Hive.isBoxOpen(_boxName)){
      return await Hive.openBox(_boxName);
    }
    return Hive.box(_boxName);
  }

  Future<T?> get<T>(String key) async{
    final box = await _box();
    return box.get(key) as T?;
  }

  Future<void> set<T>(String key, T value) async{
    final box = await _box();
    await box.put(key, value);
  }

  Future<void> remove(String key) async{
    final box = await _box();
    await box.delete(key);
  }

  Future<void> clear() async{
    final box = await _box();
    await box.clear();
  }
}