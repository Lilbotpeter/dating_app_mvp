import 'package:dating_china_app_mvp/features/profile/data/dto/profile_dto.dart';
import 'package:dating_china_app_mvp/features/profile/domain/entities/profile.dart';

extension ProfileDtoX on ProfileDto{
  Profile toEntity() => Profile(
    id: id, 
    displayName: displayName, 
    age: age, 
    gender: gender, 
    langs: langs,
    avatarUrl: avatarUrl,
    lat: lat,
    lng: lng,
    verified: verified,
    );
}

extension ProfileX on Profile{
  ProfileDto toDto() => ProfileDto(
    id: id, 
    displayName: displayName, 
    age: age, 
    gender: gender,
    langs: langs,
    avatarUrl: avatarUrl,
    lat: lat,
    lng: lng,
    verified: verified,
    );
}