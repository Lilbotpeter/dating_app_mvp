import 'package:dating_china_app_mvp/core/network/dio_client.dart';
import 'package:dating_china_app_mvp/features/profile/data/dto/profile_dto.dart';
import 'package:dio/dio.dart';

class ProfileRemoteDs {
  final Dio _dio;
  ProfileRemoteDs(DioClient client) : _dio = client.dio;

  Future<ProfileDto?> fetch() async{
    final res = await _dio.get('/profile/me');
    if(res.data == null) return null;
    return ProfileDto.fromJson(Map<String,dynamic>.from(res.data));
  }

  Future<ProfileDto> upsert(ProfileDto dto) async{
    final res = await _dio.post('/profiles', data: dto.toJson());
    return ProfileDto.fromJson(Map<String, dynamic>.from(res.data));
  }
}