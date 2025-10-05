import 'package:dating_china_app_mvp/features/home/data/datasources/home_local_ds.dart';
import 'package:dating_china_app_mvp/features/home/data/datasources/home_remote_ds.dart';
import 'package:dating_china_app_mvp/features/home/domain/entities/home_entity.dart';
import 'package:dating_china_app_mvp/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository{
  final HomeLocalDs local;
  final HomeRemoteDs remote;

  HomeRepositoryImpl({
    required this.local,
    required this.remote
  });

  @override
  Future<HomeEntity> getHomeData() async {
   try{
      final res = await remote.fetchData();
      return res.toEntity();
   }catch (_){
      final lo = await local.fetchData();
      return lo.toEntity();

   }
  }

}