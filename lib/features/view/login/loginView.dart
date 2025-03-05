import 'package:flutter/material.dart';
import 'package:safeSpace/features/view/login/widget/login_view_builder.dart';

class Loginview extends StatelessWidget {
  const Loginview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginViewBuilder(),
    );
  }
}
