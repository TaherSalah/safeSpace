import 'package:flutter/material.dart';
import 'package:safespaceapp/features/view/home/homeView.dart';
import 'package:safespaceapp/features/view/login/loginView.dart';
import 'package:safespaceapp/features/view/onboarding/onboardingView.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String onBoardingRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRout = "/register";
  static const String homeRoute = "/home";
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
