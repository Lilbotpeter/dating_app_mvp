import 'package:dating_china_app_mvp/core/error/data_state.dart';
import 'package:dating_china_app_mvp/core/usecase/usecase.dart';
import 'package:dating_china_app_mvp/features/home/domain/entities/home_entity.dart';
import 'package:dating_china_app_mvp/features/home/domain/repositories/home_repository.dart';
import 'package:dio/dio.dart';

class GetHomeData extends Usecase<DataState<HomeEntity>, NoParams>{
  final HomeRepository repo;
  GetHomeData(this.repo);

  @override
  Future<DataState<HomeEntity>> call(NoParams params) async {
    try{
      final data = await repo.getHomeData();
      return DataSuccess(data);
    }catch(e){
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(),
          message: "",
        )
      );

    }
  }
}