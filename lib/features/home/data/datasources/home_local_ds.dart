import 'package:dating_china_app_mvp/core/storage/key_value_storage.dart';
import 'package:dating_china_app_mvp/features/home/data/dto/home_dto.dart';

class HomeLocalDs {
  Future<HomeDto> fetchData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return HomeDto(
      greeting: "Welcome back (Local)", 
      highlights: ["Local cached highlight 1", "Local cached highlight 2"]);
  }
}