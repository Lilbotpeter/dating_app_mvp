import 'package:dating_china_app_mvp/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final double borderRadius;
  final BoxFit fit;

  const AppLogo({
    super.key,
    this.size = 120,
    this.borderRadius = 24,
    this.fit = BoxFit.cover
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        width: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.asset( 
            AppAssets.logo,
            fit: fit, ),
        ),
    );
  }
}