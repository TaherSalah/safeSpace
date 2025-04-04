import 'package:flutter/material.dart';
import 'package:safeSpace/features/view/home/widget/homeViewItemBuilder.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7E8DA),
      body: SafeArea(child: HomeViewItemBuilder()),
    );
  }
}
