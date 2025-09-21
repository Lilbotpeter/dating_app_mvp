class ProfileDto {
  final String id;
  final String displayName;
  final int age;
  final String gender;
  final List<String> langs;
  final String? avatarUrl;
  final double? lat;
  final double? lng;
  final bool verified;

  ProfileDto({
    required this.id,
    required this.displayName,
    required this.age,
    required this.gender,
    required this.langs,
    this.avatarUrl,
    this.lat,
    this.lng,
    this.verified = false
  });

  factory ProfileDto.fromJson(Map<String,dynamic> json) => ProfileDto(
    id: json['id'] as String, 
    displayName: json['displayName'] as String, 
    age: (json['age'] as num).toInt(), 
    gender: json['gender'] as String, 
    langs: (json['langs'] as List).map((e) => e.toString()).toList(),
    avatarUrl: json['avatar'] as String?,
    lat: (json['lat'] as num?)?.toDouble(),
    lng: (json['lng'] as num?)?.toDouble(),
    verified: (json['verified'] as bool?) ?? false,
    );

  Map<String, dynamic> toJson() => {
    'id': id,
    'displayName': displayName,
    'age': age,
    'gender': gender,
    'langs': langs,
    'avatar': avatarUrl,
    'lat': lat,
    'lng': lng,
    'verified': verified,
  };
}