import 'package:dating_china_app_mvp/core/error/data_state.dart';
import 'package:dating_china_app_mvp/core/usecase/usecase.dart';
import 'package:dating_china_app_mvp/features/profile/domain/entities/profile.dart';
import 'package:dating_china_app_mvp/features/profile/domain/usecases/clear_profile.dart';
import 'package:dating_china_app_mvp/features/profile/domain/usecases/fetch_remote_profile.dart';
import 'package:dating_china_app_mvp/features/profile/domain/usecases/get_local_profile.dart';
import 'package:dating_china_app_mvp/features/profile/domain/usecases/upsert_profile.dart';
import 'package:dating_china_app_mvp/features/profile/presentation/bloc/profile_event.dart';
import 'package:dating_china_app_mvp/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetLocalProfile getLocal;
  final FetchRemoteProfile fetchRemote;
  final UpsertProfile upsert;
  final ClearProfile clear;

  ProfileBloc({
    required this.getLocal,
    required this.fetchRemote,
    required this.upsert,
    required this.clear,
  }) : super(const ProfileLoading()){
    on<ProfileStarted>(_onStarted);
    on<ProfileRefreshed>(_onRefreshed);
    on<ProfileSaved>(_onSaved);
    on<ProfileCleared>(_onCleared);
  }

  Future<void> _onStarted(ProfileStarted event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());

    final local = await getLocal(const NoParams());
    if(local is DataSuccess<Profile?> && local.data != null){
      print("local is not null");
      emit(ProfileLoaded(local.data!));
    }else{
       print("local is  null");
      emit(const ProfileEmpty());
    }

    final remote = await fetchRemote(const NoParams());
    if(remote is DataSuccess<Profile?> && remote.data != null){
      emit(ProfileLoaded(remote.data!));
    }
  }

  Future<void> _onRefreshed(ProfileRefreshed event, Emitter<ProfileState> emit) async{
    final remote = await fetchRemote(const NoParams());
    switch (remote) {
      case DataSuccess<Profile?>():
        final profile = remote.data;
        if(profile != null ) emit(ProfileLoaded(profile));
      case DataFailed():
        emit(ProfileError(remote.error?.message ?? 'Refresh failed'));
    }
  }

  Future<void> _onSaved(ProfileSaved event, Emitter<ProfileState> emit) async {
    final res = await upsert(UpsertProfileParams(event.profile));
    switch (res){
      case DataSuccess<Profile>():
        emit(ProfileLoaded(res.data!));
      case DataFailed():
        emit(ProfileError(res.error?.message ?? 'Save failed'));
    }
  }

  Future<void> _onCleared(ProfileCleared event,Emitter<ProfileState> emit) async {
    final res = await clear(const NoParams());
    switch (res) {
      case DataSuccess<void>():
        emit(const ProfileEmpty());
      case DataFailed():
        emit(ProfileError(res.error?.message ?? 'Clear failed'));
    }
  }
}