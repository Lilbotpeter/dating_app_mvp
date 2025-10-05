import 'package:dating_china_app_mvp/core/widgets/app_logo.dart';
import 'package:dating_china_app_mvp/features/profile/domain/entities/profile.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final Profile? profile;
  const ProfileHeader({
    super.key,
    this.profile
    });

  @override
  Widget build(BuildContext context) {
    final name = profile?.displayName ?? 'Guest';
    final detail = profile != null
      ? '${profile!.age} • ${profile!.gender}'
      : 'Tap edit to complete your prifile';
      
    return Row(
      children: [
        CircleAvatar(
          radius: 42,
          backgroundImage: profile?.avatarUrl != null ? NetworkImage(profile!.avatarUrl!) : null,
          child: profile?.avatarUrl == null
            ? const AppLogo(size: 84,borderRadius: 42,)
            : null,
        ),
        const SizedBox(width: 24,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: 4,),
              Text(detail, style: Theme.of(context).textTheme.bodyMedium,)
            ],
          )
          ),
      ],
    );
  }
}