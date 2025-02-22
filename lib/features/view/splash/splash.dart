import 'package:flutter/material.dart';
import 'package:safespaceapp/features/view/splash/widget/splashItemBuilder.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffaeaff7),
      body: SafeArea(child: SplashItemBuilder()),
    );
  }
}
