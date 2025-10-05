import 'package:dating_china_app_mvp/core/error/data_state.dart';
import 'package:dating_china_app_mvp/features/home/domain/entities/home_entity.dart';

abstract class HomeRepository {
  Future<HomeEntity> getHomeData();
}