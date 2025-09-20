import 'package:equatable/equatable.dart';

class Profile extends Equatable{
  final String id;
  final String displayName;
  final int age;
  final String gender;
  final List<String> langs;
  final String? avatarUrl;
  final double? lat;
  final double? lng;
  final bool verified;

  const Profile({
    required this.id,
    required this.displayName,
    required this.age,
    required this.gender,
    required this.langs,
    this.avatarUrl,
    this.lat,
    this.lng,
    this.verified = false,
  });

  Profile copyWith({
    String? id,
    String? displayName,
    int? age,
    String? gender,
    List<String>? langs,
    String? avatarUrl,
    double? lat,
    double? lng,
    bool? verified,
  }){
    return Profile(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      langs: langs ?? this.langs,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      verified: verified ?? this.verified,
    );
  }

  @override
  List<Object?> get props => [id, displayName, age, gender, langs, avatarUrl, lat, lng, verified];
}