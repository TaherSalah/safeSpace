import 'package:flutter/material.dart';

class HomeViewItemBuilder extends StatelessWidget {
  const HomeViewItemBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Icon(Icons.drag_handle_sharp)],
    );
  }
}
