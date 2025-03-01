import 'package:flutter/material.dart';
import 'package:safe_space_app/features/view/chat/chatView.dart';
import 'package:safe_space_app/features/view/emergency/emergencyView.dart';
import 'package:safe_space_app/features/view/home/homeView.dart';
import 'package:safe_space_app/features/view/login/loginView.dart';
import 'package:safe_space_app/features/view/main/mainView.dart';
import 'package:safe_space_app/features/view/onboarding/onboardingView.dart';
import 'package:safe_space_app/features/view/sound/soundView.dart';

import '../../features/emergencyUser/emergencyUser.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String onBoardingRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRout = "/register";
  static const String homeRoute = "/home";
  static const String mainRoute = "/main";
  static const String emergencyRoute = "/emergency";
  static const String soundRoute = "/sound";
  static const String chatRoute = "/chat";
  static const String emergencyUserRoute = "/emergencyUser";
}

class RouteGenerator {
  static Route<dynamic> getRoute(
    RouteSettings settings,
    BuildContext context,
  ) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const Loginview());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.emergencyRoute:
        return MaterialPageRoute(builder: (_) => const EmergencyView());
      case Routes.soundRoute:
        return MaterialPageRoute(builder: (_) => const SoundView());
      case Routes.chatRoute:
        return MaterialPageRoute(builder: (_) => Chatview());
      case Routes.emergencyUserRoute:
        return MaterialPageRoute(builder: (_) => EmergencyUser());
      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
      // ignore: deprecated_member_use
      builder: (context) => WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, true);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(title: const Text("Page Not Found")),
          body: const Center(
            child: Text("Page Not Found"),
          ),
        ),
      ),
    );
  }
}
