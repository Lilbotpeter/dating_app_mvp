import 'package:dating_china_app_mvp/features/home/data/dto/home_dto.dart';

class HomeRemoteDs {
  Future<HomeDto> fetchData() async{
    // Wating for real connect api
    await Future.delayed(const Duration(milliseconds: 400));
    throw Exception("Remote not ready yet");
  }
}