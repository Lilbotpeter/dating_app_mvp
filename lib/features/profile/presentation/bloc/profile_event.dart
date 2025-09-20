import 'package:dating_china_app_mvp/features/profile/domain/entities/profile.dart';
import 'package:equatable/equatable.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class ProfileStarted extends ProfileEvent {
  const ProfileStarted();
}

class ProfileRefreshed extends ProfileEvent {
  const ProfileRefreshed();
}

class ProfileSaved extends ProfileEvent{
  final Profile profile;
  const ProfileSaved(this.profile);

  @override
  List<Object?> get props => [profile];

}

class ProfileCleared extends ProfileEvent {
  const ProfileCleared();
}