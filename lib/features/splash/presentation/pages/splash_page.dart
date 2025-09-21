import 'package:dating_china_app_mvp/core/widgets/app_logo.dart';
import 'package:dating_china_app_mvp/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:dating_china_app_mvp/features/splash/presentation/bloc/splash_event.dart';
import 'package:dating_china_app_mvp/features/splash/presentation/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    // context.read<SplashBloc>().add(const SplashStarted());
    BlocProvider.of<SplashBloc>(context).add(const SplashStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc,SplashState>(
        listener: (ctx,state){
          if(state is SplashGoOnboard){
            Modular.to.navigate('/onboard/');
          } else if( state is SplashGoHome){
            Modular.to.navigate('/shell/home/');
          } else if( state is SplashError ){
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(content: Text(state.message))
            );
          }
        },
        child: Center(child: AppLogo(size: 140,)),
        ),
    );
  }
}