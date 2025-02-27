import 'package:flutter/material.dart';
import 'package:safe_space_app/features/view/home/widget/homeViewItemBuilder.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: HomeViewItemBuilder()),
    );
  }
}
