import 'package:dating_china_app_mvp/core/error/data_state.dart';
import 'package:dating_china_app_mvp/core/usecase/usecase.dart';
import 'package:dating_china_app_mvp/features/splash/domain/usecases/check_onboarding.dart';
import 'package:dating_china_app_mvp/features/splash/presentation/bloc/splash_event.dart';
import 'package:dating_china_app_mvp/features/splash/presentation/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState>{
  final CheckOnboarding checkOnboarding;
  
  SplashBloc(this.checkOnboarding) : super(const SplashInitial()){
    on<SplashStarted>(_onStarted);
  }

  Future<void> _onStarted(SplashStarted e, Emitter<SplashState> emit) async {
    emit(const SplashLoading());
    try{
      final result = await checkOnboarding(const NoParams());
      if(result is DataSuccess<bool>){
        emit(result.data! ? const SplashGoHome() : const SplashGoOnboard());
      }else if(result is DataFailed<bool>){
        emit(SplashError(result.error?.message ?? 'Unknow Error'));
      }
    }catch(e){
      emit(SplashError('Splash Failed : $e'));
    }
  }

}