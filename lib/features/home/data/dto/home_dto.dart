import 'package:dating_china_app_mvp/features/home/domain/entities/home_entity.dart';

class HomeDto {
  final String greeting;
  final List<String> highlights;

  HomeDto({
    required this.greeting,
    required this.highlights,
  });

  factory HomeDto.fromJson(Map<String, dynamic> json) => HomeDto(
    greeting: json['greeting'] ?? '', 
    highlights: List<String>.from(json['highlights'] ?? [])
    );
  
  Map<String, dynamic> toJson() => {
    'greeting' : greeting,
    'highlights' : highlights,
  };

  HomeEntity toEntity() => HomeEntity(
    greeting: greeting, 
    highlight: highlights,
    );
  
  factory HomeDto.fromEntity(HomeEntity entity) => HomeDto(
    greeting: entity.greeting, 
    highlights: entity.highlight,
    );
}