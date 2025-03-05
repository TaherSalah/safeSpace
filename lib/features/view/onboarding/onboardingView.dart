import 'package:flutter/material.dart';
import 'package:safeSpace/features/view/onboarding/widget/onboardingItemBuilder.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffaeaff7),
      body: SafeArea(child: OnboardingItemBuilder()),
    );
  }
}
