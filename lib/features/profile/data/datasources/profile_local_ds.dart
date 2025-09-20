import 'package:dating_china_app_mvp/core/storage/hive_box_name.dart';
import 'package:dating_china_app_mvp/features/profile/data/dto/profile_dto.dart';
import 'package:hive/hive.dart';

class ProfileLocalDs {
  Box get _box => Hive.box(HiveBoxNames.profile);
  static const _key = 'me';

  Future<ProfileDto?> get() async{
    final raw = _box.get(_key);
    if(raw == null) return null;
    return ProfileDto.fromJson(Map<String, dynamic>.from(raw));
  }

  Future<void> put(ProfileDto dto) async{
    await _box.put(_key, dto.toJson());
  }

  Future<void> clear() async{
    await _box.delete(_key);
  }
}