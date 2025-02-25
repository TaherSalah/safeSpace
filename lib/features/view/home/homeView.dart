import 'package:flutter/material.dart';
import 'package:safespaceapp/features/view/home/widget/homeViewItemBuilder.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeViewItemBuilder(),
    );
  }
}
