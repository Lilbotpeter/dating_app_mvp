import 'package:dating_china_app_mvp/core/widgets/loading_overlay.dart';
import 'package:dating_china_app_mvp/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dating_china_app_mvp/features/profile/presentation/bloc/profile_event.dart';
import 'package:dating_china_app_mvp/features/profile/presentation/bloc/profile_state.dart';
import 'package:dating_china_app_mvp/features/profile/presentation/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileOverviewPage extends StatefulWidget {
  const ProfileOverviewPage({super.key});

  @override
  State<ProfileOverviewPage> createState() => _ProfileOverviewPageState();
}

class _ProfileOverviewPageState extends State<ProfileOverviewPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(ProfileStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile' , style: Theme.of(context).textTheme.titleMedium,)),
      body: BlocBuilder<ProfileBloc,ProfileState>(
        builder: (context,state){
          final showOverlay = state is ProfileLoading;
          final profile = state is ProfileLoaded ? state.profile : null;
          final content = ListView(
            padding: const EdgeInsets.all(24),
            children: [
              GestureDetector(
                onTap: () => Modular.to.navigate('/shell/profile/edit'),
                child: ProfileHeader(profile: profile),
              ),
              
              const SizedBox(height: 24,),
              
            ],
          );
          return LoadingOverlayWrapper(
            show: showOverlay,
            message: 'LOADING...',
            child: content);
        }
        ),
    );
  }
}