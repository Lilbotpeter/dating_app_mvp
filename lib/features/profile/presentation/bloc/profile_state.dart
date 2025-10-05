import 'package:dating_china_app_mvp/features/profile/domain/entities/profile.dart';
import 'package:equatable/equatable.dart';

sealed class ProfileState extends Equatable{
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileEmpty extends ProfileState {
  const ProfileEmpty();
}

class ProfileLoaded extends ProfileState{
  final Profile profile;
  const ProfileLoaded(this.profile);
  @override
  List<Object?> get props => [profile];
}

class ProfileError extends ProfileState{
  final String message;
  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileSavedSuccess extends ProfileLoaded {
  const ProfileSavedSuccess(super.profile);
}

